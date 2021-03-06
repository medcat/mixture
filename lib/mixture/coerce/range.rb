# encoding: utf-8
# frozen_string_literal: true

module Mixture
  module Coerce
    # Handles coercion of the Integer class.
    class Range < Base
      type Types::Range

      coerce_to(Types::Object, Itself)
      coerce_to(Types::Range, Itself)
      coerce_to(Types::String, :to_s)
      coerce_to(Types::Array, :to_a)
    end
  end
end
