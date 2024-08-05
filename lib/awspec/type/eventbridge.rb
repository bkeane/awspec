module Awspec::Type
  class Eventbridge < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_bus(@display_name)
    end

    def id
      @id ||= resource_via_client.name if resource_via_client
    end

    def has_rule?(rule_name, target_arn)
      rule = find_rule(@id, rule_name)
      return !rule.nil? if target_arn.nil?

      target = find_target(@id, rule_name, target_arn)
      return !target.nil?
    end
  end
end
