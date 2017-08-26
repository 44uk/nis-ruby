class Nis::Struct
  # @attr [String] data
  # @see https://nemproject.github.io/#unconfirmedTransactionMetaData
  class UnconfirmedTransactionMetaData
    include Nis::Util::Assignable
    attr_accessor :data

    def self.build(attrs)
      new(attrs)
    end

    def to_s
      @data
    end
  end
end
