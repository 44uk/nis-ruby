module Nis::Unit
  # @attr [String] value
  class Balance
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
    def ==(other)
      @value == other.value
    end
  end
end
