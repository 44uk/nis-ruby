module Nis::Unit
  # @attr [String] value
  class Balance
    include Comparable

    attr_accessor :value

    def initialize(value)
      @value = value.to_i
    end

    # @return [Float]
    def in_nem
      @value.to_f / 1_000_000
    end

    # @return [String]
    def to_s
      @value.to_s
    end

    # @return [Integer]
    def to_i
      @value
    end

    # @return [Boolean]
    def <=>(other)
      @value <=> other.to_i
    end

    %w(+ -).each do |op|
      define_method op do |other|
        a = instance_variable_get('@value')
        b = other.to_i
        self.class.new(a.send(op, b))
      end
    end
  end
end
