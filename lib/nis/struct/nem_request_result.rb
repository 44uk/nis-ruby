class Nis::Struct
  # @see http://bob.nem.ninja/docs/#nemRequestResult
  class NemRequestResult
    include Nis::Util::Assignable

    attr_accessor :type, :code, :message

    def self.build(json)
      new(json)
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

    def to_s
      @message
    end
  end
end
