# frozen_string_literal: true

RSpec::Matchers.define :have_route_key do |route_key|
  match do |type|
    type.has_route_key?(route_key, @integration_uri)
  end

  chain :with_target do |integration_uri|
    @integration_uri = integration_uri
  end
end
