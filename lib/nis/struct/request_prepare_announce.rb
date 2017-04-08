class Nis::Struct
  # @attr [Nis::Struct::Transaction] transaction
  # @attr [String] privateKey
  # @see http://bob.nem.ninja/docs/#requestPrepareAnnounce
  class RequestPrepareAnnounce
    include Nis::Util::Assignable
    attr_accessor :transaction, :privateKey

    alias :private_key :privateKey
    alias :private_key= :privateKey=

    def self.build(attrs)
      new(attrs)
    end
  end
end
