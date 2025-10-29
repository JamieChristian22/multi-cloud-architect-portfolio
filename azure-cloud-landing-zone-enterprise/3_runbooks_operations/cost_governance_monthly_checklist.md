# Monthly Cost Governance Checklist

- Pull Azure Cost Management report filtered by `tag:costcenter`.
- Check any resource in Prod using SKU higher than agreed baseline.
- Review Log Analytics retention (30 days hot, archive older).
- Verify Storage lifecycle rules are moving cold data -> Cool/Archive.
- Confirm budget alerts fired (or not) for the month.
