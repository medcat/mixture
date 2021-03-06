# encoding: utf-8
# frozen_string_literal: true

module Mixture
  module Extensions
    # Extends the attribute definition to allow coercion.
    module Coercable
      # Performs the coercion for the attribute and the value.
      # It is used in a `:update` callback.
      #
      # @see Coerce.perform
      # @param attribute [Attribute] The attribute
      # @param value [Object] The new value.
      # @return [Object] The new new value.
      # @raise [CoercionError] If an error occurs while a coercion is
      #   running.
      def self.coerce_attribute(attribute, value)
        return value unless attribute.options[:type]
        Coerce.perform(attribute.options[:type], value)
      end

      # Called by Ruby when the module is included.
      #
      # @param base [Object]
      # @return [void]
      # @api private
      def self.included(base)
        base.attributes.callbacks[:update] << method(:coerce_attribute)
      end
    end
  end
end
