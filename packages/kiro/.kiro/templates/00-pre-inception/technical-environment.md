# Technical Environment — [Project Name]

**Owner:** [SA name]
**Last updated:** [Date]
**Version:** [v0.X]

---

## 1. Stack

| Layer | Choice | Version | Rationale |
|---|---|---|---|
| Language | [e.g., TypeScript] | 5.x | [why] |
| Runtime | [e.g., Node.js] | 20.x LTS | [why] |
| Framework | [e.g., NestJS] | 10.x | [why] |
| Database | [e.g., PostgreSQL] | 16.x | [why] |
| Cache | [e.g., Redis] | 7.x | [why] |
| Queue | [e.g., SQS / Kafka / RabbitMQ] | — | [why] |
| Frontend (if any) | [e.g., React + Vite] | 18.x / 5.x | [why] |

## 2. Cloud / Hosting Target

**Target:** [AWS / GCP / Azure / on-prem]
**Region:** [e.g., ap-southeast-1]
**Environments:** dev, staging, prod

**Status:** [Confirmed / Open — pending An/ITS + BTS]

## 3. Prohibited Libraries

[Libraries the team should NOT use, and why.]

| Library | Reason |
|---|---|
| [e.g., moment.js] | Maintenance mode, use date-fns |
| [e.g., request] | Deprecated, use node-fetch |

## 4. Required Libraries (KAFI standard)

| Library | Purpose | Version |
|---|---|---|
| [Logging lib] | Structured logging | [version] |
| [Audit lib] | TT 96/2020 audit trail | [version] |

## 5. Example Code Patterns

### Service skeleton

```typescript
// Example: KAFI standard service pattern
import { Injectable } from '@nestjs/common';
import { AuditService } from '@kafi/audit';

@Injectable()
export class ExampleService {
  constructor(private readonly audit: AuditService) {}
  
  async doSomething(actor: Actor, input: Input) {
    return this.audit.wrap('do-something', actor, async () => {
      // business logic here
    });
  }
}
```

### API endpoint pattern

```typescript
@Controller('endpoints')
export class ExampleController {
  @Post()
  @Authorize('role')
  async create(@Body() dto: CreateDto, @CurrentUser() user: User) {
    return this.service.create(user, dto);
  }
}
```

## 6. Integration Constraints

| System | Constraint | Source |
|---|---|---|
| [e.g., Bravo] | EOD only, no real-time | `00-knowledge/systems-catalog.md` |
| [e.g., VSD / HNX] | Settlement only, no exchange API for X | KB §X |

## 7. Build & Deployment

- **Package manager:** [e.g., pnpm 9.x]
- **Build tool:** [e.g., turbo / nx / lerna]
- **CI:** [e.g., GitHub Actions]
- **CD:** [e.g., ArgoCD / manual]

## 8. Observability Standards

- **Logging:** [structured JSON to stdout, ingested by [tool]]
- **Metrics:** [Prometheus / CloudWatch / etc.]
- **Tracing:** [OpenTelemetry / X-Ray / etc.]
- **Alerting:** [Pagerduty / Opsgenie / Slack]

## 9. Security Baseline

- **Auth:** [JWT / OAuth / OIDC]
- **AuthZ:** [RBAC / ABAC]
- **Secrets:** [AWS Secrets Manager / Vault / env vars]
- **Encryption:** [TLS 1.3, AES-256 at rest]

---

*This document drives Infrastructure Design (Stage 13) and is referenced by Code Generation (Stage 14).*
