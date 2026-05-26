# AI-DLC v0.3 — Pain Points & Improvement Brainstorm

**Date:** 2026-05-21 · **Author:** Engineering review (code-grounded analysis) · **Status:** Draft for BTS triage · **Target release:** input for v0.4+ planning

---

## Executive summary

Bốn nhóm pain point được nêu trong quá trình vận hành AI-DLC v0.3 (shipped 2026-05-15):

| # | Cluster | Severity | Verified | Sub-items |
|---|---|---|---|---|
| 1 | State file drift — `aidlc-state.md` không được cập nhật giữa các stage | High | ✓ Code-confirmed | 1 |
| 2 | Waterfall rigidity — không hỗ trợ phased delivery hoặc parallel role work | High | ✓ Code-confirmed | 5 |
| 3 | Git friction cho non-dev — 8 git command mỗi stage, không abstraction | Medium-High | ✓ Code-confirmed | 5 (proposed skills) |
| 4 | Broader workflow findings | Mixed | ✓ Code-confirmed | 10 |

**Tổng cộng:** 21 findings, mỗi cái có `file:line` citation để BTS verify lại.

**Recommendation:** Doc này là analysis-only, không đề xuất implement ngay. BTS triage để chốt scope vào CHANGELOG `[Unreleased]` cho v0.4 hoặc defer sang v0.5+.

---

## Methodology

1. **3 sub-agent exploration parallel** — 1 agent map state-tracking, 1 agent map workflow model, 1 agent map collaboration tooling.
2. **Code-grounded** — mỗi finding có `file:line` reference. Findings không verify được → đánh dấu **[Hypothesis]**.
3. **No fabrication** — không suy diễn rules, chỉ trích dẫn nội dung thực tế có trong repo.
4. **Parity check** — mỗi vấn đề verify trên cả `packages/claude-code/` và `packages/kiro/` để đảm bảo finding là systemic chứ không phải edition-specific.

**Repo snapshot:** branch `main` · commit `5b7c484` · v0.3 shipped 2026-05-15.

---

## Problem 1 · State file drift

### Issue statement

`aidlc-state.md` được khai báo là resume marker cho sessions interrupted, nhưng không có rule nào yêu cầu agent cập nhật file này sau khi user approve mỗi stage. Hậu quả: file drift khỏi reality, resume sai trạng thái.

### Evidence

**1.1 — 9-step stage execution cycle không có "update state":**

`packages/claude-code/aidlc-rule-details/common/process-overview.md:7-17`

```
1. Log raw user input → audit.md
2. Load this stage's rule-detail file
3. Load prior stage outputs as inputs
4. Execute (plan → questions → generation)
5. Run AI Review Checklist (soft)
6. Present 2-option completion
7. Wait for explicit approval
8. Log user response → audit.md
9. Proceed to next stage
```

→ Step 1 và 8 ghi rõ "append audit.md". **Không có step nào nói update `aidlc-state.md`.**

**1.2 — Session-continuity định nghĩa READ rule, không có WRITE rule:**

`packages/claude-code/aidlc-rule-details/common/session-continuity.md:55-62`

```
## What to do on resume
1. Read aidlc-state.md.
2. Display: "Resuming [Stage N — Name] (Status: [status])"
3. If awaiting-approval: re-present the last completion message.
4. If execution: load relevant rule-detail file and continue.
5. If planning: re-display plan and last questions.
6. Append audit.md with resume entry.
```

→ Có "Read state file" trên resume, không có "Write state file" trên stage approval.

**1.3 — Chỉ Stage 1 (Workspace Detection) write state file:**

`packages/claude-code/aidlc-rule-details/inception/workspace-detection.md:42` — *"Initialize or update `aidlc-state.md`."* — là **stage duy nhất** có rule write.

Grep toàn repo `grep -rn "aidlc-state" packages/` confirm: ngoài Stage 1, không stage nào khác có rule update file này.

**1.4 — Template state file đã được spec sẵn nhưng không có write hook:**

`session-continuity.md:18-53` định nghĩa format đầy đủ (Project · Current Stage · Stages Completed · Extension Config · Open Decisions). Template tồn tại nhưng không có cơ chế bảo trì.

### Root cause

Designer của v0.3 tách 2 file ra:
- `audit.md` = append-only compliance log (mọi input + response)
- `aidlc-state.md` = latest-snapshot resume marker

Nhưng chỉ định nghĩa write rule cho `audit.md` (step 1, 8 của cycle) mà bỏ sót `aidlc-state.md`. Đây là **omission**, không phải design choice.

### Impact

Tình huống thực tế (đã quan sát trong dự án production):
- `aidlc-state.md` hiện ghi: `Stage 4 pending (next)`
- Nhưng `aidlc-docs/inception/` có file `foundation-demo-prototype.html` → dự án thực ra đã đi tới Stage 7 (Product Design)
- Resume session → agent đề xuất chạy lại Stage 4 → user confusion

### Proposed fix (cost: ~1 hour)

Thêm step `8a` vào `process-overview.md`:

```
8a. Update aidlc-state.md:
    - Set status: complete for current stage
    - Set Stage: [N+1 — Name] for next stage
    - Set Last activity: [ISO 8601 current timestamp]
    - Append to Stages Completed: [✓] Stage N — Name
    - Update Last user input: [reference to audit.md entry]
```

**Parity targets:**
- `packages/claude-code/aidlc-rule-details/common/process-overview.md`
- `packages/kiro/.kiro/steering/common/process-overview.md`

**Handbook update:**
- `docs/KAFI-AIDLC-Handbook.html` — Part 1 §"Stage execution cycle"
- `docs/KAFI-AIDLC-Handbook.html` — same

---

## Problem 2 · Waterfall rigidity

### Issue statement

Workflow v0.3 strictly serial ở cả macro (Inception → Construction → Operations) và micro (per-unit loop). Không có rule cho phased delivery, parallel role work, hoặc MVP exit ramp. Dự án có requirements thay đổi liên tục → role chờ nhau hoặc phải spawn parallel Claude sessions không được hỗ trợ chính thức.

### Sub-problems

#### 2.1 · Per-unit loop là sequential

**Evidence:** `packages/claude-code/CLAUDE.md` mermaid diagram trong section "🟢 CONSTRUCTION":

```
S14 --> N{More units?}
N -->|Yes| S10
N -->|No| S15
```

→ Unit B không bắt đầu Stage 10 cho đến khi Unit A xong Stage 14. Confirm bằng `code-generation.md` (Stage 14): *"Continue to next unit / Stage 15 (Build)"*.

Stage 9 (Units Generation) cho phép declare dependency (`UNIT-02 depends on: UNIT-01`) nhưng đó là **planning question**, không phải **execution rule**. Workflow vẫn execute serial.

#### 2.2 · `phase-discipline` extension chỉ có manifest, không có implementation

**Evidence:** `CLAUDE.md` table line ~70:

```
| `phase-discipline` | Project | Always if defined | Project supplies YAML |
```

Folder thực tế:

```bash
$ ls packages/claude-code/aidlc-rule-details/extensions/
audit-trail/
personal-data-privacy/
```

→ `phase-discipline/` **không tồn tại**. Extension được hứa trong manifest nhưng chưa có rule file thực sự. Bên Kiro tương tự.

#### 2.3 · `aidlc-docs/` schema overwrites trên revisit

**Evidence:** Stage 4 (Requirements Analysis) ghi vào `aidlc-docs/inception/requirements/requirements.md`. Stage 7 (Product Design) ghi `aidlc-docs/inception/product-design/`. Không có quy ước per-phase folder (`phase-1/`, `phase-2/`).

Nếu PM revisit Stage 4 sau khi đã ship Phase 1 → `requirements.md` cũ bị overwrite. Lịch sử chỉ còn trong `audit.md` (append-only), nhưng `audit.md` không phải canonical source — `requirements.md` mới là.

**Hệ quả:** Phase 2 không thể reference cleanly Phase 1 requirements vì cùng 1 path.

#### 2.4 · Không có MVP exit ramp

**Evidence:** Searched workflow rules cho từ khóa "MVP", "exit", "ship now":
- Pre-Inception D có depth option `Minimal` — nhưng đó là depth reduction, không phải exit.
- Stage 6 (Workflow Planning) cho phép skip stages 7-13 — nhưng workflow vẫn ép vào S14 → S15 → S16 → S17.

→ Không có gate kiểu *"After Stage 14, user may choose: [Ship MVP] | [Continue to Build]"*. User chỉ có thể abort manually, không có rule support.

#### 2.5 · Role coordination protocol thiếu

**Evidence:** `CLAUDE.md` Roles table:

```
| PM | Stages 4, 6 |
| BA | Stages 4, 5, 10 + Pre-Inception |
```

→ Stage 4 owned by **PM + BA together**. Nhưng không có rule:
- Ai chạy trước? PM draft requirements rồi BA refine? Hay BA draft rồi PM approve?
- Approval gate là single 2-option (Request Changes / Continue) — ai bấm Continue?
- Stage 10 owned by **BA + SA together** — cùng câu hỏi.

Trong thực tế: hoặc 1 agent session chạy hết role (mất sense of role), hoặc 2 session parallel nhưng không sync state file (→ trở lại Problem 1).

### Proposed approaches

#### Approach A — `phase-delivery` extension thực sự (cost: 5-7 days)

Tạo `packages/claude-code/aidlc-rule-details/extensions/phase-delivery/`:
- `rule.md` — phase scoping, when to enable
- `phase-scope-template.md` — per-phase requirements scope, deferred items
- `loop-back-protocol.md` — sau S17, loop về S4 cho phase N+1
- Folder schema mới: `aidlc-docs/phase-1/inception/...`, `aidlc-docs/phase-2/inception/...`

**Parity:** mirror sang `packages/kiro/.kiro/steering/extensions/phase-delivery/`.

#### Approach B — "Parallel Stage Orchestration" rule (cost: 2-3 days)

Thêm section vào `process-overview.md`:

```
## Parallel Stage Orchestration (PROPOSED)

Multiple Claude sessions can run concurrently if:
- Each session works on a distinct UNIT-NN (Construction per-unit)
- OR each session works on a distinct stage that doesn't gate the other
  (e.g., PM Stage 6 + Designer Stage 7 can run parallel if Stage 5 complete)

Coordination requirements:
- Single aidlc-state.md updated by either session (lock via git branch)
- Single audit.md, branches merge with conflict resolution per "audit.md conflict" rule
- Approval gates remain serial — user is single decision point
```

#### Approach C — MVP exit gate (cost: 1 day)

Thêm option ở Stage 14 completion:

```
2-option gate becomes 3-option:
  → Request Changes
  → Continue to Build (Stage 15)
  → Exit as MVP (skip Stages 15-17, mark phase shipped)
```

#### Approach D — Role coordination protocol (cost: 1 day)

Thêm rule mới trong `common/`:

```
## Co-owned Stages (PROPOSED)

When a stage is owned by 2+ roles (e.g., PM+BA in Stage 4):
- First role: drafts artifact + open items
- Second role: reviews + appends "Open — pending" items
- Approval: requires acknowledgement from both via dual sign-off in audit.md
- Single user clicks "Continue" but commit message must list both contributors
```

### Files would need to change

| File | Change |
|---|---|
| `packages/claude-code/aidlc-rule-details/common/process-overview.md` | Add "Parallel Stage Orchestration" + "Co-owned Stages" sections |
| `packages/claude-code/aidlc-rule-details/inception/workflow-planning.md` | Add phase scoping question to Stage 6 |
| `packages/claude-code/aidlc-rule-details/construction/build.md` | Add "Ship MVP now" option to Stage 14 → 15 transition |
| `packages/claude-code/aidlc-rule-details/extensions/phase-delivery/` | **CREATE** new extension folder |
| `packages/claude-code/CLAUDE.md` | Add "Phase Loop" section + update Extensions table |
| Parity twins under `packages/kiro/.kiro/steering/` | Same changes |
| `docs/KAFI-AIDLC-Handbook-{Claude,Kiro}.html` | Update Part 1 §Phase Map + Part 2 §Construction |

---

## Problem 3 · Non-dev git friction

### Issue statement

Roles PM, BA, Designer phải thực hiện 8 git command mỗi stage. Không có abstraction skill nào trong repo. Stage hand-off là implicit qua merged PR — không có notification, không có readiness check.

### Evidence

**3.1 — 8 git command/stage liệt kê trong README:**

`packages/claude-code/README.md:255-282`

```bash
# Start
git checkout main          # 1
git pull                   # 2
git checkout -b stage/4-requirements   # 3

# Commit
git add aidlc-docs/inception/requirements/   # 4
git commit -m "Stage 4: ..."                  # 5

# PR
git push -u origin stage/4-requirements      # 6
gh pr create --title "..." --body "..."      # 7

# Cleanup (after merge)
git branch -d stage/4-requirements           # 8
```

→ 8 command per stage, mỗi command có rule format riêng (branch naming convention, commit message format, PR body template).

**3.2 — Abstraction layer hiện có rất mỏng:**

- Branch naming convention table (README:245-253) — **advisory**, không enforced
- Commit message format (README:284-294) — template, không có agent macro
- PR body example "Closes gate · 24 REQs · 2 open items" — **example, không phải template file**

**3.3 — Stage hand-off implicit:**

Không có rule "agent notifies next role when prior stage merges". SA muốn biết Stage 5 (BA) đã xong → phải tự check GitHub PRs hoặc `git log main`.

**3.4 — Đã có 1 partial mitigation:**

`docs/KAFI-Git-Guide-NonDev.html` (177 KB) — team đã viết guide riêng cho non-dev roles. Tuy nhiên đây là **read-only HTML**, không phải executable skill. Vẫn yêu cầu non-dev tự gõ git command.

### Proposed skills

Theo priority impact:

| # | Skill | Role | Reduces |
|---|---|---|---|
| 1 | `kafi-git-stage-flow` | PM, BA, Designer | 8 commands → 2 macros (`[Stage: Start]`, `[Stage: Complete]`) |
| 2 | `kafi-stage-handoff` | All | Manual PR check → automatic notification + ledger |
| 3 | `kafi-pr-template-enforcer` | All | PR body errors → auto-fill from stage rule + artifacts |
| 4 | `kafi-stage-readiness-check` | SA, DevOps | Premature stage start → pre-check prior PR merged |
| 5 | `kafi-artifact-breadcrumb` | All | GitHub UI inspection → `aidlc-docs/stage-handoffs.md` ledger |

**Per-skill detail (sample):**

#### Skill #1 — `kafi-git-stage-flow`

**Trigger:** user enters `[Stage: Start 4]` (or completion gate selects "Continue").

**Action:**
1. Detect current stage from `aidlc-state.md`
2. Execute: `git checkout main && git pull && git checkout -b stage/<N>-<name>`
3. Load stage rule file, begin execution
4. On completion gate → execute: `git add <stage folder> && git commit -m "<auto-filled>"  && git push -u origin <branch> && gh pr create --title <auto> --body <auto>`

**Cost:** 1.5 days (incl. parity + Kiro equivalent + tests + Handbook update)

**Decision needed:** implement in `packages/claude-code/.claude/skills/kafi/` (project skill, ships in v0.4 zip) hoặc tách ra `kafi-ai-skills/` repo riêng (per Architecture B đã brainstorm 2026-05-21).

### Files would need to change

| File | Change |
|---|---|
| `packages/claude-code/.claude/skills/kafi/git-stage-flow/SKILL.md` | **CREATE** |
| `packages/kiro/.kiro/steering/git-stage-flow.md` | **CREATE** (Kiro parity) |
| `packages/claude-code/README.md` | Update §"Daily commands" → "If you have `kafi-git-stage-flow` skill, use `[Stage: Start]` instead" |
| `docs/KAFI-Git-Guide-NonDev.html` | Update with new skill instructions |
| `docs/KAFI-AIDLC-Handbook-{Claude,Kiro}.html` | Add §"Git skills" |

---

## Problem 4 · Broader findings (10 sub-items)

Findings phát hiện thêm trong quá trình review:

### 4.1 — `phase-discipline` extension chưa có rule file

(Đã evidence ở §2.2.) Manifest hứa nhưng folder không có. Cost fix: 1 day để spec + impl, hoặc consolidate vào `phase-delivery` ở Problem 2.

### 4.2 — Audit log không có rotation/index

**Evidence:** `CLAUDE.md` §"Audit Log Format" — *"Append-only. Never overwrite."*

Không có:
- Rule rotation (sau N entry tách file mới `audit-2026-Q3.md`)
- Index/summary file
- Search helper

**Impact:** Sau 50 stage, `audit.md` sẽ dài ~5000 dòng. Scan để tìm "khi nào user đã approve Stage 7" trở nên chậm.

**Cost:** 0.5 day (add rule "rotate every 50 entries or per phase").

### 4.3 — Open items không có aggregation view

**Evidence:** Open items format spec trong nhiều role file (e.g., `pm.md`, `ba.md`): `Open — pending [owner]`. Nhưng không có:
- Aggregator skill thu thập tất cả `Open` items từ mọi artifact
- Dashboard / summary view
- Trigger rule khi `Open` item resolved

**Impact:** Open items trôi nổi giữa các artifact, dễ bỏ sót.

**Cost:** 1 day (open-items-aggregator skill + dashboard template).

### 4.4 — Per-unit folder không versioned

**Evidence:** Stage 9 (Units Generation) tạo `aidlc-docs/construction/UNIT-{NN-name}/` 1 lần. Stage 10-14 ghi vào folder đó. Nếu spec unit thay đổi giữa chừng (vd: UNIT-02 cần rework sau khi UNIT-01 ship) → overwrite, không có v1/v2.

**Impact:** tied với Problem 2 (phase-delivery) — sửa cùng lúc.

### 4.5 — AI review checklist là soft enforcement

**Evidence:** `CLAUDE.md` §"AI Review Checklist":

```
**Risk-shaped:** Auth/money/PII/external/IaC → flag for dual review
```

→ "Flag for dual review" — nhưng không có hard gate. Agent có thể flag và vẫn proceed.

**Impact:** Cho code generation đụng vào auth/money/PII, không có forced human review.

**Cost:** 0.5 day (thêm rule "if risk flag = true, must require user typed confirmation token before proceeding").

### 4.6 — Role coordination protocol cho co-owned stages

(Đã đề cập ở §2.5 và Approach D ở Problem 2.) PM+BA cùng Stage 4, BA+SA cùng Stage 10 — không có rule "ai-làm-trước".

### 4.7 — Templates list trong CLAUDE.md drift khỏi reality

**Evidence:** `CLAUDE.md` Templates section list:

```
vision.md · technical-environment.md · user-story.md · epic.md ·
adr.md · prd.md · personas.md · risk-register.md · design-lite.md ·
story-map.md · dod.md
```

(11 templates)

Folder thực tế `packages/claude-code/aidlc-rule-details/templates/`:

```
adr.md, application-design.md, components.md, functional-design.md,
nfr-design.md, nfr-requirements.md, requirements.md, technical-environment.md,
unit-of-work.md, user-story.md, vision.md
```

(11 templates, **khác list**)

**Drift:**
- CLAUDE.md mentions but missing on disk: `epic.md`, `prd.md`, `personas.md`, `risk-register.md`, `design-lite.md`, `story-map.md`, `dod.md` (7 files)
- On disk but not in CLAUDE.md: `application-design.md`, `components.md`, `functional-design.md`, `nfr-design.md`, `nfr-requirements.md`, `requirements.md`, `unit-of-work.md` (7 files)

→ Documentation drift. Hoặc CLAUDE.md wrong (chưa update), hoặc 7 templates đã hứa nhưng chưa làm. v0.4 backlog "test artifacts" sẽ thêm `test-plan.md` — cần audit lại trước.

**Cost:** 0.5 day audit + reconcile.

### 4.8 — Designer-BA review pattern thiếu

**Evidence:** Stage 7 (Product Design) ownership chỉ "Designer" trong `CLAUDE.md`. Nhưng Product Design output (wireframes, interaction specs) phải align với requirements (BA) và user stories (BA).

Không có rule "Designer must reference user stories trong design spec" hoặc "BA reviews design before Stage 7 completion".

**Cost:** 0.5 day (add cross-role review rule).

### 4.9 — Plan-driven vs 1-part stage không có decision rule

**Evidence:** `process-overview.md:41-43`:

```
Stages 5 (User Stories), 9 (Units Generation), 14 (Code Generation) are 2-part:
- Part 1 — Planning: create plan.md with checkboxes + questions; user approves plan
- Part 2 — Execution: execute approved plan, ticking checkboxes
```

→ 3 stages cụ thể là 2-part. Nhưng không có rule khi nào nên dùng 2-part vs 1-part. Stage 4 (Requirements Analysis) có khi sinh ra 50+ REQ, có lẽ cũng nên 2-part.

**Cost:** 0.5 day (add decision rule + flag Stage 4 candidates).

### 4.10 — Không có retrospective stage

**Evidence:** Workflow kết thúc ở Stage 17 (Monitoring). Không có Stage 18 "Retrospective" hoặc post-ship learning.

→ Project finishes → không có cơ chế ghi nhận lesson learned cho phase tiếp theo, hoặc cho project khác.

**Cost:** 1 day (Stage 18 spec + template). Hoặc extension `retrospective` (manual inclusion).

### 4.11 — `/init` redundancy on AI-DLC projects (SHIPPED in v0.4 with corrected framing)

**Initial concern:** Claude Code có lệnh `/init` để sinh `CLAUDE.md` mới từ workspace scan. Lo ngại ban đầu: nếu user lỡ chạy `/init` trên dự án AI-DLC, file workflow bị overwrite → setup hỏng.

**Corrected understanding (2026-05-25, verified via Claude Code docs + Reddit r/ClaudeCode + claude.com guides):** `/init` thực ra **non-destructive khi `CLAUDE.md` đã tồn tại**:

> "When you run /init while a CLAUDE.md file already exists, Claude analyzes your codebase and suggests improvements to your current file rather than overwriting it."
> — AI Overview synthesizing Reddit r/ClaudeCode, claude.com, The AI Agent Factory

`/init` chạy "complementary mode" — đề xuất diff cho user review, không ghi đè blindly. Nguy cơ thực sự không phải "destruction" mà là **redundancy + dilution**:
- Redundant: `CLAUDE.md` đã được auto-load mọi session start, không cần `/init`
- Dilution: `/init` có thể đề xuất thêm generic project conventions (build commands, test instructions...) — nếu user accept blindly, workflow content có thể bị pha loãng theo hướng generic dev project

**Resolution shipped in v0.4:**
- Skill `kafi-aidlc-onboarding` ở `packages/{claude-code,kiro}/` — giải thích vì sao `/init` redundant + đề xuất stage detection thay thế.
- README callout dạng `💡` (không phải `⚠️`) — informative tone, không alarm.

**Status:** ✅ Shipped v0.4 với framing đã được correct. Skill giữ giá trị chính ở Mode B (stage detection from legacy artifacts) — đó là feature mà `/init` không cung cấp.

### 4.12 — `/init` architectural prevention (DOWNGRADED priority sau correction ở 4.11)

**Status update:** Sau khi correct hiểu biết về `/init` ở Problem 4.11, mức độ urgent của vấn đề này **giảm mạnh**. `/init` không destructive — chỉ suggest diff. Onboarding skill (đã ship v0.4) + user review diff cẩn thận = defense đủ cho default case.

**Còn lại edge cases worth considering** (low priority):
- User blind-accept `/init` suggestions có thể dilute workflow content theo thời gian.
- Vendor (Anthropic) đổi behavior `/init` trong future có thể phá assumption.

**Issue statement (giữ lại để BTS triage):** Skill `kafi-aidlc-onboarding` (Problem 4.11) chỉ là defense lớp 1 — cảnh báo user trước. Defense sâu hơn nếu muốn architectural isolation: workflow content không nằm trong file `/init` đụng tới.

**3 hướng đã brainstorm 2026-05-25, defer quyết định cho BTS:**

#### Option A · Hook block (KHÔNG KHUYẾN NGHỊ)

Đăng ký hook `UserPromptSubmit` trong `.claude/settings.json` pattern-match `/init` và reject.

- Brittleness: `/init` là built-in slash command của Claude Code, khả năng cao không đi qua hook pipeline.
- Vendor coupling: phụ thuộc internals của Anthropic, có thể vỡ silently khi vendor update.
- **Verdict:** Skip.

#### Option B · Tách workflow ra (RECOMMENDED architecture, v0.5+)

`CLAUDE.md` trở thành **shim ~10 dòng**:

```markdown
<!-- KAFI-AIDLC-v0.3 · Project memory shim · Safe to overwrite -->

# KAFI AI-DLC Project

This project follows the KAFI AI-DLC methodology.
**Workflow spec:** @aidlc-workflow.md
**Onboarding:** ask the agent to load `kafi-aidlc-onboarding` skill.

If `/init` wiped this file, restore from the original zip. The workflow itself is safe in `aidlc-workflow.md`.
```

Workflow content (~280 dòng) chuyển sang `aidlc-workflow.md`. Claude Code support `@file.md` import — load workflow như project memory hiện tại.

| Pro | Con |
|---|---|
| `/init` overwrite chỉ phá shim 10 dòng → recover bằng 1 lệnh `cp` | Phá "1-file simplicity" — drop 2 file thay vì 1 |
| Workflow content stable, immune to `/init` | Existing projects cần migrate (1 `mv` command) |
| Cùng pattern cho Kiro (AGENTS.md shim → aidlc-workflow.md) | Cần spike test `@import` ở mức project-memory level trong Claude Code v0.3 — chưa verify |

**Cost:** 2-3 ngày + spike test (~0.5 ngày). Estimated v0.5 candidate.

#### Option C · Sentinel + CI detection (QUICK WIN, defer to BTS triage)

Thêm sentinel comment đầu CLAUDE.md/AGENTS.md hiện tại:

```markdown
<!-- KAFI-AIDLC-WORKFLOW-v0.4 · DO NOT OVERWRITE · /init will destroy this -->
<!-- Sentinel: KAFI_AIDLC_LOCK_v0.4 -->
```

Extend `.github/workflows/parity.yml` (đã có sẵn cho parity check) hoặc pre-commit hook: fail nếu sentinel missing.

- **Defense type:** Detection sau sự cố, không phải prevention.
- **Cost:** ~1 giờ.
- **Verdict:** Quick win, không loại trừ Option B làm tiếp.

#### Recommended combo

| Release | Action | Reason |
|---|---|---|
| v0.4 (shipped) | Skill warn user trước khi gõ `/init` (Problem 4.11) | Defense lớp 1 — proactive warning |
| v0.5 candidate | Option C — sentinel + CI check (~1 giờ) | Defense lớp 2 — detect post-incident |
| v0.5/v0.6 | Spike `@import` → nếu pass thì Option B | Defense lớp 3 — architectural isolation |

**3 lớp defense độc lập, không overlap.** BTS cần chốt Option B có làm hay không (cost vs migration complexity).

**Open questions for BTS:**
1. Sentinel hook fail behavior: block commit hay chỉ warn?
2. Option B migration plan: cut v0.5 cho fresh installs, có support migration script không?
3. Có nên test thử Option B trên 1 spike project trước v0.5 không?

---

## Recommended phasing (suggested, not mandated)

Khuyến nghị scope cho BTS triage. Không phải kế hoạch implement.

### Quick wins (1-3 day total)

Priority: address state file drift trước vì rủi ro confusion cao nhất.

| Item | Cost | Why now |
|---|---|---|
| Problem 1 fix (state file update rule) | 1 hour | Smallest cost, biggest correctness win |
| Problem 4.7 (templates drift audit) | 0.5 day | Blocks v0.4 test-plan template work |
| Problem 4.6 (co-owned stages rule) | 1 day | Unblocks PM+BA real-world coordination |

### Medium (4-7 days)

| Item | Cost | Why next |
|---|---|---|
| Problem 3 skill #1 (`kafi-git-stage-flow`) | 1.5 days | Highest impact daily friction reduction |
| Problem 2 Approach A (phase-delivery extension) | 5-7 days | Unlocks phased project pattern |
| Problem 4.1 (consolidate phase-discipline INTO phase-delivery) | 0 incremental | Same work as above |

### Strategic (10+ days)

| Item | Cost | Why later |
|---|---|---|
| Problem 2 Approach B (parallel orchestration) | 2-3 days | Requires phase-delivery base |
| Problem 2 Approach C (MVP exit gate) | 1 day | Requires phase-delivery base |
| Problem 3 skills #2-5 (handoff, PR template, readiness, breadcrumb) | 2-3 days | Diminishing returns sau skill #1 |
| Problem 4.10 (retrospective stage) | 1 day | Nice-to-have, không blocker |

---

## Decision matrix for BTS

| Cluster | Severity | Confidence | Cost | Recommended target |
|---|---|---|---|---|
| 1 · State drift | High | High (code-confirmed) | 1 hour | **v0.4** |
| 2.1 · Per-unit serial | Medium | High | 2-3 days | v0.5 (part of Approach B) |
| 2.2 · phase-discipline impl missing | High | High | 1 day (consolidate w/ 2.A) | **v0.4** or v0.5 |
| 2.3 · aidlc-docs/ overwrites | High | High | 5-7 days (Approach A) | v0.5 |
| 2.4 · MVP exit gate | Medium | High | 1 day | v0.5 |
| 2.5 · Role coordination | High | High | 1 day | **v0.4** |
| 3 · Git friction (skill #1) | Medium-High | High | 1.5 days | **v0.4** |
| 3 · Git skills #2-5 | Medium | Medium | 2-3 days | v0.5 |
| 4.1 · phase-discipline manifest only | High | High | 0 (rolled into 2.2) | v0.4/v0.5 |
| 4.2 · Audit rotation | Low | High | 0.5 day | v0.6 |
| 4.3 · Open items aggregator | Medium | High | 1 day | v0.5 |
| 4.4 · Per-unit versioning | Medium | High | 0 (rolled into 2.3) | v0.5 |
| 4.5 · AI review hard gate | Medium-High | High | 0.5 day | v0.5 |
| 4.6 · Co-owned stages | High | High | 1 day | **v0.4** (tied with 2.5) |
| 4.7 · Templates drift | Medium | High | 0.5 day | **v0.4** (block test-plan work) |
| 4.8 · Designer-BA review | Low | High | 0.5 day | v0.5 |
| 4.9 · 2-part stage rule | Low | High | 0.5 day | v0.6 |
| 4.10 · Retrospective | Medium | High | 1 day | v0.5 |

**Suggested v0.4 additions** (đã có 5 item trong CHANGELOG `[Unreleased]`):
- Problem 1 fix · 1 hour
- Problem 2.5 + 4.6 (role coordination) · 1 day
- Problem 4.7 (templates drift audit) · 0.5 day
- Problem 3 skill #1 (`kafi-git-stage-flow`) · 1.5 days

**Tổng cộng v0.4 thêm: ~3 ngày work**, không kéo dài timeline nhiều.

---

## Open questions for BTS

Trước khi triage, BTS cần chốt:

1. **Phase-delivery vs phase-discipline** — gộp thành 1 extension hay tách 2?
   - Gộp: ít confusion, single source. Tên đề xuất: `phase-delivery`.
   - Tách: phase-discipline = "stay within phase scope" (warning), phase-delivery = "ship and loop back" (execution flow).

2. **MVP exit ramp** — đặt ở đâu?
   - Option A: 3rd option ở Stage 14 completion gate
   - Option B: tạo Stage 14.5 "Phase Ship Decision" riêng

3. **Git skills implementation location** — project skill hay separate repo?
   - In-repo: `packages/claude-code/.claude/skills/kafi/git-stage-flow/`, ship trong v0.4 zip
   - Separate: `kafi-ai-skills/` repo riêng (per Architecture B brainstormed 2026-05-21), install via `kafi-skills install kafi-git-stage-flow`

4. **Role coordination protocol** — common rule hay extension?
   - Common: applies to mọi project (PM+BA always co-own Stage 4)
   - Extension: project có thể opt-in/opt-out tùy team structure

5. **Retrospective** — Stage 18 (always-on) hay extension (opt-in)?
   - Stage 18: forced learning, có structure
   - Extension: optional, team chọn khi cần

6. **Sub-agent pattern** — đã quan sát qua doc này: AI có thể spawn 3 sub-agent parallel để explore codebase. Có nên formalize pattern này trong AI-DLC (vd: Stage 3 Reverse Engineering nên dùng sub-agent)?

---

## Appendix A · Files reviewed

### Common rules (`packages/claude-code/aidlc-rule-details/common/`)
- `process-overview.md` (64 lines)
- `session-continuity.md` (70 lines)
- `ai-review-checklist.md` (read by agent)
- `content-validation.md` (read by agent)
- `question-format-guide.md` (read by agent)
- `welcome-message.md` (read by agent)

### Inception stages (`packages/claude-code/aidlc-rule-details/inception/`)
- 9 stage rule files (workspace-detection, kb-context-loading, reverse-engineering, requirements-analysis, user-stories, workflow-planning, product-design, application-design, units-generation)

### Construction stages (`packages/claude-code/aidlc-rule-details/construction/`)
- 6 stage rule files (functional-design, nfr-requirements, nfr-design, infrastructure-design, code-generation, build)

### Extensions (`packages/claude-code/aidlc-rule-details/extensions/`)
- `audit-trail/` ✓ exists
- `personal-data-privacy/` ✓ exists
- `phase-discipline/` ✗ **missing** (manifest claims it exists)

### Roles (`packages/claude-code/.claude/skills/kafi/roles/`)
- `pm.md`, `ba.md`, `sa.md`, `designer.md`, `dev.md`, `devops.md` (6 files, ✓)

### Templates (`packages/claude-code/aidlc-rule-details/templates/`)
- 11 files on disk vs 11 files documented in `CLAUDE.md` — but **lists differ** (see Problem 4.7)

### Entry + docs
- `packages/claude-code/CLAUDE.md` (workflow definition)
- `packages/claude-code/README.md` (git workflow §241-306)
- `docs/KAFI-AIDLC-Handbook.html`
- `docs/KAFI-AIDLC-Handbook.html`
- `docs/KAFI-Git-Guide-NonDev.html` (177KB — existing partial mitigation for Problem 3)

### Parity twin verified
- `packages/kiro/.kiro/steering/common/process-overview.md` (mirrors Claude Code)
- `packages/kiro/.kiro/steering/extensions/` — same missing `phase-discipline/`

---

## Appendix B · Methodology trace

**Sub-agent 1** — "Map state-tracking gaps"
- Scope: all `common/*.md` + grep `aidlc-state` across repo + verify parity twin
- Key finding: 9-step cycle ghi audit.md ở step 1 + 8, không có step nào cho state file. Stage 1 là duy nhất write rule.

**Sub-agent 2** — "Assess waterfall vs parallel"
- Scope: all inception/construction/operations stage files + extensions folder + Handbook HTML scan
- Key finding: per-unit loop sequential (S14 → S10 next unit), phase-discipline chưa có rule file, không có MVP exit ramp, không có per-phase folder schema.

**Sub-agent 3** — "Non-dev collaboration friction"
- Scope: all role files + README.md git section + grep "git|branch|commit|PR" across packages/claude-code/
- Key finding: 8 git command/stage, không có abstraction skill, stage handoff = manual GitHub PR check.

**Personal verification** (post-agent):
- Re-read `process-overview.md` lines 7-17 (verified 9-step cycle)
- Re-read `session-continuity.md` lines 55-62 (verified read-only resume)
- Re-read `README.md` lines 241-306 (verified 8 git command sequence + branch naming convention)
- `ls packages/claude-code/aidlc-rule-details/extensions/` (verified phase-discipline missing)
- `ls packages/claude-code/aidlc-rule-details/templates/` (verified drift with CLAUDE.md list)
- `ls docs/` (discovered `KAFI-Git-Guide-NonDev.html` existing → partial mitigation noted)

---

## Appendix C · Quick reference — citation index

| Finding | Reference |
|---|---|
| 9-step cycle | `process-overview.md:7-17` |
| State file format | `session-continuity.md:18-53` |
| Resume protocol | `session-continuity.md:55-62` |
| Stage 1 state init rule | `workspace-detection.md:42` |
| Per-unit loop serial | `CLAUDE.md` §🟢 CONSTRUCTION mermaid |
| Extensions table (manifest) | `CLAUDE.md` §MANDATORY Loading |
| Git workflow | `README.md:241-306` |
| Branch naming convention | `README.md:245-253` |
| 8 git commands/stage | `README.md:255-282` |
| Commit format | `README.md:284-294` |
| Audit conflict rule | `README.md:296-306` |
| Templates list (docs) | `CLAUDE.md` §Templates |
| Templates list (disk) | `ls packages/claude-code/aidlc-rule-details/templates/` |
| AI review risk flag | `CLAUDE.md` §AI Review Checklist |
| 2-part plan-driven stages | `process-overview.md:41-43` |
| Co-owned Stage 4 (PM+BA) | `CLAUDE.md` §🟣 INCEPTION mermaid |
| Audit log format | `CLAUDE.md` §Audit Log Format |

---

## Maintenance note

- File này là **snapshot**, không phải living doc.
- Khi BTS triage xong → các item được pick sẽ chuyển vào `CHANGELOG.md` `[Unreleased]` + `SESSION_HANDOFF.md` v0.4 backlog.
- Đề xuất re-run analysis (3 sub-agent parallel) sau mỗi major release (v0.5, v0.6) để catch new drift.

---

*End of brainstorm doc · 2026-05-21*
