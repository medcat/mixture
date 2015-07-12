# encoding: utf-8

module Mixture
  module Types
    class Integer < Numeric
      options[:primitive] = ::Integer
      options[:method] = :to_integer
      as :int, :integer
    end
  end
end
