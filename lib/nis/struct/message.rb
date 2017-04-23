class Nis::Struct
  # @attr [String] value
  # @attr [Integer] type
  # @attr [String] payload
  class Message
    attr_accessor :value, :type, :payload

    TYPE_PLAIN     = 1
    TYPE_ENCRYPTED = 2

    def initialize(value)
      @value = value
      @type  = TYPE_PLAIN
    end

    # @return [Boolean]
    def encrypted?
      @type == TYPE_ENCRYPTED
    end

    # @return [Boolean]
    def plain?
      @type == TYPE_PLAIN
    end

    # @return [Integer]
    def bytesize
      payload.bytesize
    end

    # @return [Boolean]
    def valid?
      bytesize <= 512
    end

    # @return [Hash]
    def to_hash
      { payload: payload, type: @type }
    end

    # @return [String]
    def to_s
      @value
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end

    private

    def payload
      @payload ||= value.unpack('H*').join
    end
  end
end
