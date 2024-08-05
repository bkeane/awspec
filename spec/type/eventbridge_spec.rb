require 'spec_helper'
Awspec::Stub.load 'eventbridge'

describe eventbridge('my-eventbridge') do
  it { should exist }
end
