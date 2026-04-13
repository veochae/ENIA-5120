# Lab 11 - LLM Reliability in Practice (ChatGPT Web)

Use ChatGPT web for this in-class activity.

Goal: compare answer quality across three prompt conditions and assess reliability.

## Question Set

Use the same three questions in all rounds.

1. Summarize two key policy trends in EV adoption from 2018 to 2024.
2. Name one likely risk of using AI in public-sector decision support.
3. Give one recommendation for reducing hallucination in LLM workflows.

## Condition A - Baseline

For each question, paste the question as-is into ChatGPT.

Record outputs in this table.

| question_id | question | response |
|---|---|---|
| q1 | Summarize two key policy trends in EV adoption from 2018 to 2024. | |
| q2 | Name one likely risk of using AI in public-sector decision support. | |
| q3 | Give one recommendation for reducing hallucination in LLM workflows. | |

## Condition B - Structured Prompt

For each question, use this prompt template:

```text
You are a careful policy analysis assistant.
Answer in 3 bullet points.
If uncertain, explicitly say what is uncertain.
Question: <PASTE QUESTION>
```

Record outputs in this table.

| question_id | question | response |
|---|---|---|
| q1 | Summarize two key policy trends in EV adoption from 2018 to 2024. | |
| q2 | Name one likely risk of using AI in public-sector decision support. | |
| q3 | Give one recommendation for reducing hallucination in LLM workflows. | |

## Condition C - Grounded Prompt (RAG-lite)

First, copy the context block below into the prompt.

```text
Context:
This dataset catalogs environmental policy actions tied to monitoring sites. It includes policy type, policy strength, funding, compliance outcomes, and timing.

Key fields include:
- policy_type (examples: Emissions Cap, EV Incentive)
- grant_amount (USD)
- inspection_count
- compliance_score (0 to 100)
- estimated_reduction_pct
- policy_adopted (TRUE/FALSE)
- start_date

Known quality issues include:
- missing values
- invalid categories
- out-of-range compliance scores
- invalid dates
- duplicate policy IDs
- merge key mismatches
```

Then use this grounded prompt template for each question:

```text
Use only the context below when possible.
If the context is insufficient, say so clearly.
Return 3 bullet points and include one line starting with "Confidence:".

<PASTE CONTEXT BLOCK>

Question: <PASTE QUESTION>
```

Record outputs in this table.

| question_id | question | response |
|---|---|---|
| q1 | Summarize two key policy trends in EV adoption from 2018 to 2024. | |
| q2 | Name one likely risk of using AI in public-sector decision support. | |
| q3 | Give one recommendation for reducing hallucination in LLM workflows. | |

## Combined Verification Table

For each row, assign:

- `correct`
- `partially_correct`
- `wrong`
- `unverifiable`

| question_id | condition | claim_check | notes |
|---|---|---|---|
| q1 | baseline | | |
| q2 | baseline | | |
| q3 | baseline | | |
| q1 | structured | | |
| q2 | structured | | |
| q3 | structured | | |
| q1 | grounded | | |
| q2 | grounded | | |
| q3 | grounded | | |

## Reflection (5-7 sentences)

Address all four:

1. Which condition improved answer quality most, and why?
2. One hallucination or weak claim you observed.
3. Did grounding reduce unverifiable claims?
4. One rule you will use before trusting an LLM answer in real work.
