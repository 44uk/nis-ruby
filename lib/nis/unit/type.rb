module Nis::Unit
  # @attr [String] value
  # @attr [String] message
  class Type
    attr_accessor :value, :message

    def initialize(value)
      @value = value
    end

    attr_reader :message

    # @return [String]
    def to_s
      @message
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end
  end
end
