class Nis::Struct
  # @attr [String] value
  # @attr [String] hash
  # @attr [Integer] id
  # @see http://bob.nem.ninja/docs/#accountPrivateKeyTransactionsPage
  class AccountPrivateKeyTransactionsPage
    include Nis::Util::Assignable
    attr_accessor :value, :hash, :id

    def self.build(attrs)
      new(attrs)
    end
  end
end
