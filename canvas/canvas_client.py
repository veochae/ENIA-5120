import logging
import mimetypes
import os
import pathlib
from typing import Any, Dict, Iterable, List, Optional

import requests

LOGGER = logging.getLogger(__name__)


class CanvasClient:
    """Thin wrapper around Canvas LMS REST API."""

    def __init__(self, base_url: str, course_id: int, token: str):
        self.base_url = base_url.rstrip("/")
        self.course_id = course_id
        self.session = requests.Session()
        self.session.headers.update(
            {
                "Authorization": f"Bearer {token}",
            }
        )

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------
    def _request(self, method: str, path: str, **kwargs) -> Any:
        url = f"{self.base_url}{path}"
        resp = self.session.request(method=method, url=url, timeout=60, **kwargs)
        if resp.status_code >= 400:
            LOGGER.error("Canvas API error %s: %s", resp.status_code, resp.text)
        resp.raise_for_status()
        if resp.headers.get("Content-Type", "").startswith("application/json"):
            return resp.json()
        return resp.text

    def _paginate(self, path: str, params: Optional[Dict[str, Any]] = None) -> Iterable[Any]:
        params = params or {}
        url = f"{self.base_url}{path}"
        while url:
            resp = self.session.get(url, params=params, timeout=60)
            if resp.status_code >= 400:
                LOGGER.error("Canvas API error %s: %s", resp.status_code, resp.text)
            resp.raise_for_status()
            data = resp.json()
            for item in data:
                yield item
            url = resp.links.get("next", {}).get("url")
            params = None  # only send params on first request

    @staticmethod
    def _slugify(text: str) -> str:
        slug = "".join(ch.lower() if ch.isalnum() else "-" for ch in text)
        slug = "-".join(filter(None, slug.split("-")))
        return slug or "page"

    # ------------------------------------------------------------------
    # Files
    # ------------------------------------------------------------------
    def upload_file(
        self,
        file_path: pathlib.Path,
        display_name: Optional[str] = None,
        folder: Optional[str] = None,
    ) -> Dict[str, Any]:
        file_path = pathlib.Path(file_path)
        if not file_path.exists():
            raise FileNotFoundError(file_path)
        content_type, _ = mimetypes.guess_type(file_path.name)
        init_payload = {
            "name": display_name or file_path.name,
            "size": file_path.stat().st_size,
            "content_type": content_type or "application/octet-stream",
        }
        if folder:
            init_payload["parent_folder_path"] = folder
        path = f"/api/v1/courses/{self.course_id}/files"
        init_resp = self._request("POST", path, data=init_payload)
        upload_url = init_resp["upload_url"]
        upload_params = init_resp["upload_params"]
        with open(file_path, "rb") as handle:
            files = {"file": handle}
            upload_resp = requests.post(upload_url, data=upload_params, files=files, timeout=60)
            upload_resp.raise_for_status()
            if upload_resp.headers.get("Content-Type", "").startswith("application/json"):
                return upload_resp.json()
            # Some Canvas instances redirect to the file metadata endpoint
            return self.session.get(upload_resp.url, timeout=60).json()

    # ------------------------------------------------------------------
    # Pages
    # ------------------------------------------------------------------
    def upsert_page(self, title: str, body: str, published: bool = True) -> Dict[str, Any]:
        slug = self._slugify(title)
        payload = {
            "wiki_page[title]": title,
            "wiki_page[body]": body,
            "wiki_page[published]": str(published).lower(),
            "wiki_page[url]": slug,
        }
        path = f"/api/v1/courses/{self.course_id}/pages/{slug}"
        resp = self.session.get(f"{self.base_url}{path}", timeout=30)
        if resp.status_code == 404:
            return self._request("POST", f"/api/v1/courses/{self.course_id}/pages", data=payload)
        resp.raise_for_status()
        return self._request("PUT", path, data=payload)

    # ------------------------------------------------------------------
    # Assignments
    # ------------------------------------------------------------------
    def list_assignments(self) -> List[Dict[str, Any]]:
        return list(
            self._paginate(
                f"/api/v1/courses/{self.course_id}/assignments",
                params={"per_page": 100},
            )
        )

    def find_assignment_id(self, name: str) -> Optional[int]:
        for assignment in self.list_assignments():
            if assignment.get("name") == name:
                return assignment.get("id")
        return None

    def ensure_assignment(
        self,
        name: str,
        points: int,
        submission_types: Optional[List[str]] = None,
        published: bool = True,
        description: Optional[str] = None,
        due_at: Optional[str] = None,
    ) -> Dict[str, Any]:
        payload = {
            "assignment[name]": name,
            "assignment[points_possible]": points,
            "assignment[published]": str(published).lower(),
            "assignment[submission_types][]": submission_types or ["online_upload"],
        }
        if description:
            payload["assignment[description]"] = description
        if due_at:
            payload["assignment[due_at]"] = due_at
        assignment_id = self.find_assignment_id(name)
        if assignment_id:
            return self._request(
                "PUT",
                f"/api/v1/courses/{self.course_id}/assignments/{assignment_id}",
                data=payload,
            )
        return self._request(
            "POST",
            f"/api/v1/courses/{self.course_id}/assignments",
            data=payload,
        )

    # ------------------------------------------------------------------
    # Submissions
    # ------------------------------------------------------------------
    def get_submissions(self, assignment_id: int) -> List[Dict[str, Any]]:
        path = f"/api/v1/courses/{self.course_id}/assignments/{assignment_id}/submissions"
        return list(self._paginate(path, params={"include[]": "submission_history"}))

    def download_attachment(self, url: str, dest_path: pathlib.Path) -> None:
        dest_path.parent.mkdir(parents=True, exist_ok=True)
        with self.session.get(url, stream=True, timeout=120) as resp:
            resp.raise_for_status()
            with open(dest_path, "wb") as handle:
                for chunk in resp.iter_content(chunk_size=8192):
                    if chunk:
                        handle.write(chunk)


def load_client_from_config(config_path: pathlib.Path) -> CanvasClient:
    import yaml

    config = yaml.safe_load(pathlib.Path(config_path).read_text())
    token_name = config.get("token_env_var", "CANVAS_API_TOKEN")
    token = os.environ.get(token_name)
    if not token:
        raise RuntimeError(
            f"Environment variable {token_name} is required for Canvas API access"
        )
    return CanvasClient(
        base_url=config["base_url"],
        course_id=int(config["course_id"]),
        token=token,
    )
