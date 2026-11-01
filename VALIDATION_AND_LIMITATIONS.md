# Architecture validation and evidence boundaries

**Scope:** NovaRetail is a fictional multi-cloud data and analytics scenario. This repository is an architecture **design exercise** with Terraform examples and review checklists. It is not evidence of production deployment, achieved availability SLAs, regulatory certification, or completed disaster-recovery testing.

## What a reviewer can inspect

| Claim / objective | Source | Evidence status |
| --- | --- | --- |
| Stakeholder goals and constraints | [Business requirements](case-study/01-business-context-and-requirements.md) | Documented design assumptions |
| Cross-cloud solution and integration | [Solution overview](case-study/02-solution-overview.md) · [Data flow](case-study/06-data-flow-and-integration.md) | Architecture narrative, not traffic measurements |
| Provider-specific design | [AWS](case-study/03-detailed-architecture-aws.md) · [Azure](case-study/04-detailed-architecture-azure.md) · [GCP](case-study/05-detailed-architecture-gcp.md) | Described architecture; deployment not independently verified |
| IaC implementation examples | [Terraform sources](infrastructure-as-code/terraform/README.md) | Source files present; valid plans/applies not asserted |
| Security and regulatory controls | [Threat model](security/threat-model.md) · [Access controls](security/data-classification-and-access-control.md) | Design intentions, not control certification |
| Reliability and incident response | [Operations overview](operations/README.md) · [Incident playbook](operations/incident-response-playbook.md) | Runbooks / simulated scenarios |
| Cost and scaling | [Cost considerations](case-study/09-cost-and-scaling-considerations.md) | Illustrative sizing; no current vendor quote |
| Review readiness | [Architecture checklist](tests-and-checklists/architecture-review-checklist.md) · [Go-live checklist](tests-and-checklists/go-live-readiness-checklist.md) | Checklist artifacts, not independently approved go-live |

## Read and validate locally

There is **no fully reproducible live environment supplied in this repository**. For a source-level review:

1. Read requirements and constraints, followed by the [architecture diagram](case-study/images/case-study_architecture-diagrams_aws-azure-gcp.png).
2. Inspect the Terraform files for resource names, provider configurations, unbound variables, networking, encryption, least privilege and cross-cloud integration assumptions.
3. If Terraform CLI is installed, try these **non-deploying** checks from the repository root:

```bash
cd infrastructure-as-code/terraform
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

These commands have **not** been executed or certified as passing as part of this README update. Initialization may download provider plugins. Terraform validation is not the same as a successful, policy-compliant plan.

4. Before any real deployment, create isolated sandbox accounts/projects, review provider settings and variable requirements, use state protection, estimate costs, and review IAM and network exposure. Do **not** run `terraform apply` on unreviewed credentials or environments.
5. For a production claim, supply a versioned plan, actual deployment evidence, cloud audit logs, tested backups/DR, operational metrics and a security review.

## Open architecture decisions / trade-offs to discuss

- **Cross-cloud connectivity:** private networks versus managed/public endpoints; segmentation, latency, egress fees and failure isolation.
- **Data residency and privacy:** region constraints, retention, pseudonymization, data contracts and legal requirements.
- **Consistency versus availability:** batch and streaming replay, ordering, deduplication, failure recovery and SLAs.
- **Cost and FinOps:** cross-cloud egress, storage lifecycle, query spend, service quotas and observability overhead.
- **Identity:** least-privilege service identities, credentials rotation, break-glass access, audit trails and key management.
- **Operating model:** accountable owners for alerts, incident escalation, cost controls, data quality and changes.

**Assessment standard:** Treat an unverified test or architectural assumption as *open*, not *passing*. Reviewers can use the linked checklists to create a concrete validation plan.
