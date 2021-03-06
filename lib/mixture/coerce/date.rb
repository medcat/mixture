# encoding: utf-8
# frozen_string_literal: true

module Mixture
  module Coerce
    # Handles coercion of the Date class.
    class Date < Base
      type Types::Date

      coerce_to(Types::Object, Itself)
      coerce_to(Types::String, :to_s)
      coerce_to(Types::Time, :to_time)
      coerce_to(Types::Date, :to_date)
      coerce_to(Types::DateTime, :to_datetime)
      coerce_to(Types::Array) { |value| value.to_time.to_a }
      coerce_to(Types::Float) { |value| value.to_time.to_f }
      coerce_to(Types::Integer) { |value| value.to_time.to_i }
      coerce_to(Types::Rational) { |value| value.to_time.to_r }
    end
  end
end
