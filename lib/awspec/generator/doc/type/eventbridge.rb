module Awspec::Generator
  module Doc
    module Type
      class Eventbridge < Base
        def initialize
          super
          @type_name = 'Eventbridge'
          @type = Awspec::Type::Eventbridge.new('my-eventbridge')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
