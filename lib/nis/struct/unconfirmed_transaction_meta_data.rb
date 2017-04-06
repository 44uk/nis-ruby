class Nis::Struct
  # @attr [String] data
  # @see http://bob.nem.ninja/docs/#unconfirmedTransactionMetaData
  class UnconfirmedTransactionMetaData
    include Nis::Util::Assignable
    attr_accessor :data

    def self.build(attrs)
      new(attrs)
    end
  end
end
