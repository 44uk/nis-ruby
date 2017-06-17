class Nis::Transaction
  # @attr [Integer] timeStamp
  # @attr [Integer] signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @see http://bob.nem.ninja/docs/#mosaicSupplyChangeTransaction
  class MosaicSupplyChange
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :type, :deadline, :signer,
                  :supplyType, :delta, :mosaicId

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias supply_type supplyType
    alias supply_type= supplyType=
    alias mosaid_id mosaicId
    alias mosaid_id= mosaicId=

    TYPE = 0x4002 # 16386 (mosaic supply change transaction)
    FEE  = 20_000_000

    INCREASE = 1
    DECREASE = 2

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
