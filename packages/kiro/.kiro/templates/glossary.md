# Glossary — [Project]

> Pre-Inception / Stage 1 KB artifact · maintained throughout
> Bilingual (Vietnamese / English) — critical for KAFI cross-team clarity
> Every domain term, abbreviation, and system name used in specs traces here

**Status:** Living document
**Owner:** BA (curates) · all roles contribute
**Last updated:** [Date]

---

## How to use

Whenever a spec (PRD, requirements, user story, data-model) introduces a domain term,
abbreviation, or system name that isn't self-evident, add it here. Specs link back so a
reader never has to guess. Keep VN + EN side by side.

---

## Domain terms

| Term (EN) | Term (VN) | Definition | First used in |
|---|---|---|---|
| Bond | Trái phiếu | A fixed-income debt instrument | PRD-01 |
| Yield | Lợi suất | Annualized return rate on a bond | view-model: Deal capture |
| Settlement date | Ngày thanh toán | Date funds + ownership transfer | data-model: Deal.settlement_date |
| Face value | Mệnh giá | Nominal value repaid at maturity | data-model: Bond.face_value |
| Coupon | Lãi suất danh nghĩa | Periodic interest payment | functional-design |

## Abbreviations

| Abbr | Full (EN) | Full (VN) | Notes |
|---|---|---|---|
| BO | Back Office | Bộ phận hậu kỳ | |
| EOD | End of Day | Cuối ngày | Batch processing window |
| NAV | Net Asset Value | Giá trị tài sản ròng | |
| KYC | Know Your Customer | Định danh khách hàng | Regulatory |

## System / product names

| Name | What it is | Owner team |
|---|---|---|
| KOS-MO | [KAFI core system] | [team] |
| Bravo | [accounting system integrated at EOD] | [team] |
| KAI Atlas | (planned) System Knowledge Base — shared context layer | Transformation Office |

## Regulatory references

| Citation | Scope | Applies to |
|---|---|---|
| TT 96/2020 | Audit trail requirements | all financial transactions |
| Decree 13/2023 | Personal data protection (PDPA) | PII fields |

## Naming conventions

[Project-specific naming rules — e.g. entity prefixes, ID formats, file naming.]

---

KB cited: `00-knowledge/` source docs · regulatory KB
Related: every spec that introduces a term links here
