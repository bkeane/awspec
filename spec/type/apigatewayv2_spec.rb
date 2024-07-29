require 'spec_helper'
Awspec::Stub.load 'apigatewayv2'

describe apigatewayv2('my-apigatewayv2') do
  it { should exist }
end
