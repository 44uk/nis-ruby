class Nis::Transaction
  # @attr [Integer] timeStamp
  # @attr [String]  signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Array <Nis::Struct::MultisigCosignatoryModification>] modifications
  # @attr [Hash] minCosignatories
  # @see http://bob.nem.ninja/docs/#multisigAggregateModificationTransaction
  class MultisigAggregateModification
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :type, :deadline, :signer,
                  :modifications, :minCosignatories

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias min_cosignatories minCosignatories
    alias min_cosignatories= minCosignatories=

    TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)
    FEE  = 16_000_000

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def type
      TYPE
    end

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
