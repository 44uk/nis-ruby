module Nis::Unit
  # @attr [String] value
  class Hash
    attr :value

    def initialize(value)
      @value = value
    end

    # @return [Boolean]
    def valid?
      !!(@value =~ /[0-9a-f]{64}/)
    end

    def to_s
      @value
    end

    def ==(other)
      @value == other.value
    end
  end
end
