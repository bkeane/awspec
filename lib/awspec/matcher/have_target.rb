# frozen_string_literal: true

RSpec::Matchers.define :have_target do |integration_uri|
  match do |type|
    type.has_target?(integration_uri)
  end
end
