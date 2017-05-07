class Nis::Struct
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
  class ProvisionNamespaceTransaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :fee, :type, :deadline, :version, :signer,
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
    def _version
      (0xFFFFFFF0 & @version)
    end

    # @return [Boolean]
    def testnet?
      (0x0000000F & @version) == Nis::Util::TESTNET
    end

    # @return [Boolean]
    def mainnet?
      (0x0000000F & @version) == Nis::Util::MAINNET
    end

    # @return [Integer]
    def fee
      @fee ||= calculate_fee
    end

    alias to_hash_old to_hash

    def to_hash
      fee
      to_hash_old
    end

    # @return [Integer]
    def calculate_fee
      FEE
    end
  end
end
