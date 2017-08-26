class Nis::Struct
  # @attr [Integer] type
  # @attr [String] code
  # @attr [String] message
  # @see https://nemproject.github.io/#nemRequestResult
  class NemRequestResult
    include Nis::Util::Assignable
    attr_accessor :type, :code, :message

    def self.build(attrs)
      new(attrs)
    end

    # @return [Boolean]
    def validation?
      @type == 1
    end

    # @return [Boolean]
    def heartbeat?
      @type == 2
    end

    # @return [Boolean]
    def status?
      @type == 4
    end

    # @return [String]
    def to_s
      @message
    end
  end
end
