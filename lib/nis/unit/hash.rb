module Nis::Unit
  # @attr [String] value
  class Hash
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    # @return [Boolean]
    def valid?
      !!(@value =~ /[0-9a-f]{64}/)
    end

    # @return [String]
    def to_s
      @value
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end
  end
end
