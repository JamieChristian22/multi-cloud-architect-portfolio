# Reviewer guide and asset provenance checklist

**Project:** multi-cloud-architect-portfolio · [README](README.md) · [License](LICENSE) · [CI runs](https://github.com/JamieChristian22/multi-cloud-architect-portfolio/actions)

## Five-minute review

1. Read the root README for purpose, limitations, and simulated versus measured results.
2. Open the project paths below to inspect tracked deliverables; their presence alone is not proof of correctness.
3. Review GitHub Actions for actual test outcomes. Queued or failed runs are not passing tests.
4. Verify input datasets, calculation methods, and evidence before citing performance outcomes.

### Project entry points

1. [case-study](<case-study>)
2. [infrastructure-as-code](<infrastructure-as-code>)
3. [operations](<operations>)
4. [security](<security>)
5. [tests-and-checklists](<tests-and-checklists>)

## Third-party asset and dataset provenance checklist

The following are **sample tracked candidates** for source and reuse-rights checks. Their inclusion does not imply they are external, unlicensed, or unsafe.

| Tracked asset candidate | Verification status |
| --- | --- |
| `case-study/images/case-study_architecture-diagrams_aws-azure-gcp.png` | **Not independently verified** — check origin and permissions |

For each external asset, record original source URL, creator/provider, terms, allowed redistribution and commercial use, and any required notices. For original or synthetic work, note how it was produced and ensure any modeled results are plainly labeled. The MIT repository license does not automatically grant rights to externally owned content.

**Security:** Never include API keys, private/customer data, or identifying screenshots in an evidence file. Treat current-branch scanning and historical secret scanning as separate checks.

This document is **navigation and review guidance**, not a security audit pass, ownership certification, or legal clearance. See [GitHub Actions](https://github.com/JamieChristian22/multi-cloud-architect-portfolio/actions) for live test results.
