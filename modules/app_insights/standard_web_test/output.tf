output "id" {
  description = "The ID of the Application Insights standard web test."
  # Monitor metric alert expects the webTests segment to be formatted as camelCase, otherwise an error will occur as:
  # Error: ID was missing the `webTests` element
  value = replace(azapi_resource.appiwt.id, "webtests", "webTests")
}
