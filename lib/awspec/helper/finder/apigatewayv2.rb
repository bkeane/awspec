# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module ApigatewayV2
      def find_apigatewayv2(name_or_id)
        apigatewayv2_client.get_apis(max_results: '500').items.find do |api|
          api.name == name_or_id || api.api_id == name_or_id
        end
      end

      def find_integration(api_id, integration_id)
        apigatewayv2_client.get_integration(api_id: api_id, integration_id: integration_id)
      end

      def find_routes(api_id)
        apigatewayv2_client.get_routes(api_id: api_id, max_results: '500').items
      end
    end
  end
end
