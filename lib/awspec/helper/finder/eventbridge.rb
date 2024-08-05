# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module EventBridge
      def find_bus(display_name)
        eventbridge_client.describe_event_bus({ name: display_name })
      rescue Aws::EventBridge::Errors::ResourceNotFoundException
        nil
      end

      def find_rule(bus_name, rule_name)
        eventbridge_client.describe_rule({
          name: rule_name,
          event_bus_name: bus_name,
        })
        rescue Aws::EventBridge::Errors::ResourceNotFoundException
          nil
      end

      def find_target(bus_name, rule_name, target_arn)
        eventbridge_client.list_targets_by_rule({ rule: rule_name, event_bus_name: bus_name }).targets.find do |target|
          target.arn == target_arn
        end
      end
    end
  end
end
