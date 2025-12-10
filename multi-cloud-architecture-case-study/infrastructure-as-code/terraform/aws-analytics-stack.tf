resource "aws_redshiftserverless_namespace" "analytics_ns" {
  namespace_name = "novaretail-analytics"
  db_name        = "analytics"
  admin_username = "analytics_admin"
  admin_user_password = "StrongPassword123!"
}

resource "aws_redshiftserverless_workgroup" "analytics_wg" {
  workgroup_name = "novaretail-analytics-wg"
  namespace_name = aws_redshiftserverless_namespace.analytics_ns.namespace_name
}
