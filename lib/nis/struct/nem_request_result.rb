class Nis::Struct
  class NemRequestResult
    include Nis::Util::Assignable

    attr_accessor :type, :code, :message

    def self.build(json)
      new(json)
    end

    def validation?
      @type == 1
    end

    def heartbeat?
      @type == 2
    end

    def status?
      @type == 4
    end

    def to_s
      @message
    end
  end
end
