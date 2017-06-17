class Nis::Transaction
  # @attr [Integer] timeStamp
  # @attr [String]  signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String]  signer
  # @attr [String]  rentalFeeSink
  # @attr [Integer] rentalFee
  # @attr [String]  newPart
  # @attr [String]  parent
  # @see http://bob.nem.ninja/docs/#provisionNamespaceTransaction
  class ProvisionNamespace
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :type, :deadline, :signer,
                  :rentalFeeSink, :rentalFee, :newPart, :parent

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias rental_fee_sink rentalFeeSink
    alias rental_fee_sink= rentalFeeSink=
    alias rental_fee rentalFee
    alias rental_fee= rentalFee=
    alias new_part newPart
    alias new_part= newPart=

    TYPE = 0x2001 # 8193 (provision namespace transaction)
    FEE  = 20_000_000

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def type
      @type ||= TYPE
    end

    # @return [Integer]
    def fee
      @fee ||= FEE
    end

    alias to_hash_old to_hash

    def to_hash
      type
      fee
      to_hash_old
    end
  end
end
