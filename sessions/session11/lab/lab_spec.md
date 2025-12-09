# Lab 11 – APIs & Web Scraping

## Goals
- Make API calls with `httr`
- Parse JSON into data frames
- Perform a basic HTML scrape with `rvest`

## Tasks
1. Use `httr::GET` to pull `https://api.sampleapis.com/futurama/characters` and store content as `api_data`.
2. Convert to a tibble called `characters_tbl` with `jsonlite::fromJSON`.
3. Use `rvest` to scrape the first table from `https://example-data.draft.dev/books` into `books_tbl`.
4. Save both data frames to knit output and describe differences between API vs scraped data.
