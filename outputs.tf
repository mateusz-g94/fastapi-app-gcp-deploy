output "public_endpoint" {
  value       = "${google_api_gateway_gateway.gw.default_hostname}/cluster"
  description = "service hostname endpoint for ai application."
}