module Nis::Unit
  class Balance
    attr :value

    def initialize(value)
      @value = value.to_i
    end

    def in_nem
      @value_in_nem ||= @value.to_f / 1_000_000
    end

    def to_s
      @value.to_s
    end

    def to_i
      @value
    end

    def ==(other)
      @value == other.value
    end
  end
end
