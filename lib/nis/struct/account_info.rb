class Nis::Struct
  # @attr [Nis::Unit::Address] address
  # @attr [Nis::Unit::Balance] balance
  # @attr [Nis::Unit::Balance] vestedBalance
  # @attr [Float] importance
  # @attr [String] publicKey
  # @attr [String] label
  # @attr [Array] harvestedBlocks
  # @see https://nemproject.github.io/#accountInfo
  class AccountInfo
    include Nis::Util::Assignable
    attr_accessor :address, :balance, :vestedBalance, :importance, :publicKey, :label, :harvestedBlocks

    alias :vested_balance :vestedBalance
    alias :vested_balance= :vestedBalance=
    alias :public_key :publicKey
    alias :public_key= :publicKey=
    alias :harvested_blocks :harvestedBlocks
    alias :harvested_blocks= :harvestedBlocks=

    def self.build(attrs)
      attrs[:address] = Nis::Unit::Address.new(attrs[:address])
      attrs[:balance] = Nis::Unit::Balance.new(attrs[:balance])
      attrs[:vestedBalance] = Nis::Unit::Balance.new(attrs[:vestedBalance])
      new(attrs)
    end
  end
end
