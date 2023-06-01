resource "google_api_gateway_api" "api_gw" {
  provider     = google-beta
  api_id       = "fastapi0101apigw"
  display_name = "API Gateway for AI App"
}

resource "google_api_gateway_api_config" "api_gw_con" {
  provider = google-beta
  api      = google_api_gateway_api.api_gw.api_id
  #   api_config_id_prefix = local.api_config_id_prefix sufix prefix unikalny
  display_name = "API Gateway Config for AI App"

  openapi_documents {
    document {
      path = "./src/apispec.yaml"
      contents = base64encode(<<-EOF
        swagger: '2.0'
        info:
            title: api-gateway
            description: API Gateway
            version: 1.0.0
        schemes:
            - https
        produces:
            - application/json
        paths:
            /v1/cluster:
                post:
                    summary: NLP Clustering API service 
                    operationId: fastapi-app-0101
                    x-google-backend:
                        address: ${google_cloud_run_service.service.status[0].url}/cluster
                    responses:
                        '200':
                            description: OK

    EOF
      )
    }
  }
}

resource "google_api_gateway_gateway" "gw" {
  provider = google-beta
  region   = "europe-west1"

  api_config = google_api_gateway_api_config.api_gw_con.id

  gateway_id   = "fastapi0101apigwgw"
  display_name = "API Gateway Gateway for AI App"

  depends_on = [google_api_gateway_api_config.api_gw_con]
}