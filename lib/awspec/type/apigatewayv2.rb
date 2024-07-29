# frozen_string_literal: true

module Awspec::Type
  class Apigatewayv2 < ResourceBase
    aws_resource Aws::ApiGatewayV2::Client

    def resource_via_client
      @resource_via_client ||= find_apigatewayv2(@display_name)
    end

    def id
      @id ||= resource_via_client.api_id
    end

    def has_route_key?(route_key, integration_uri)
      routes = find_routes(id)

      if integration_uri.nil?
        return routes.any? { |r| r.route_key == route_key }
      end

      routes.each do |r|
        next if r.route_key != route_key
        next if r.target.nil?

        integration_id = r.target.split('/')[-1]
        integration = find_integration(id, integration_id)
        return false if integration.nil?

        return integration.integration_uri == integration_uri
      end

      false
    end
  end
end
