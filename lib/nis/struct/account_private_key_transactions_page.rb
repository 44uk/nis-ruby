class Nis::Struct
  # @attr [String] value
  # @attr [String] hash
  # @attr [Integer] id
  # @see https://nemproject.github.io/#accountPrivateKeyTransactionsPage
  class AccountPrivateKeyTransactionsPage
    include Nis::Util::Assignable
    attr_accessor :value, :hash, :id

    def self.build(attrs)
      new(attrs)
    end
  end
end
