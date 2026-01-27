# Change Management and Release Process

- All IaC changes go through pull requests and code review.
- Changes to schemas are coordinated with data consumers.
- Releases to production follow:
  1. Dev → Test → Prod promotion with validation at each stage.
  2. Scheduled maintenance windows for breaking changes.
