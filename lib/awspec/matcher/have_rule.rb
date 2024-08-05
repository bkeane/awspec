# frozen_string_literal: true

RSpec::Matchers.define :have_rule do |rule_name|
  match do |type|
    type.has_rule?(rule_name, @with_target)
  end

  chain :with_target do |target_arn|
    @with_target = target_arn
  end
end

