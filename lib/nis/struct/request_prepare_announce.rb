class Nis::Struct
  # @attr [Nis::Struct::Transaction] transaction
  # @attr [String] privateKey
  # @see https://nemproject.github.io/#requestPrepareAnnounce
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
