module Awspec::Generator
  module Doc
    module Type
      class Apigatewayv2 < Base
        def initialize
          super
          @type_name = 'Apigatewayv2'
          @type = Awspec::Type::Apigatewayv2.new('my-apigatewayv2')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
