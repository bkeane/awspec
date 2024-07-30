# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Lambda
      def find_lambda(id)
        selected = []
        res = lambda_client.list_functions

        loop do
          selected += res.functions.select do |function|
            function.function_name == id || function.function_arn == id
          end
          break if res.next_marker.nil?

          res = lambda_client.list_functions({
                                               marker: res.next_marker
                                             })
        end

        selected.single_resource(id)
      end

      def select_all_resource_policy_statements(id)
        policy = lambda_client.get_policy({ function_name: id })
        return [] if policy.policy.nil?

        JSON.parse(policy.policy)['Statement']
      end

      def select_event_source_by_function_arn(function_arn)
        res = lambda_client.list_event_source_mappings({
                                                         function_name: function_arn
                                                       })
        res.event_source_mappings
      end

      def select_all_lambda_functions
        lambda_client.list_functions.map do |response|
          response.functions
        end.flatten
      end

      def select_all_tags_by_function_arn(function_arn)
        res = lambda_client.list_tags({ resource: function_arn })
        res.tags
      end
    end
  end
end
