# frozen_string_literal: true

require_relative "validator/version"

# module Enum
#   module Validator
#     class Error < StandardError; end
#     # Your code goes here...
#   end
# end

module Enum
  extend ActiveSupport::Concern
  module Validator
  class_methods do
    # Custom method to define enum validations
    def validate_enum(enum_key, **options)
      # Define a custom setter method for the enum
      define_method("#{enum_key}=") do |value|
        super(value)
      rescue ArgumentError
        @attributes.write_cast_value(enum_key.to_s, value)
      end

      # Add validation to ensure the value is included in the enum values
      validates enum_key, inclusion: { in: send(enum_key.to_s.pluralize).keys }, **options
    end
  end
end
end
