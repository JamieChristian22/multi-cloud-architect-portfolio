# Rotating Secrets in Key Vault

1. App identities (managed identity) pull secrets at runtime, so we can rotate without redeploy.
2. Add new secret version in Key Vault.
3. Update connection string reference on App Service to new secret name/version if needed.
4. Force restart App Service / Container Apps revision to pick up new secret.
5. Mark old secret version as disabled, then purge when safe.
