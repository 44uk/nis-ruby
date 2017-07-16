class Nis::Transaction
  # @attr [Nis::Struct::MosaicId] mosaic_id
  # @attr [Symbol] supplyType
  # @attr [Integer] delta
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @attr [Symbol] network
  # @see http://bob.nem.ninja/docs/#mosaicSupplyChangeTransaction
  class MosaicSupplyChange
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :mosaicId, :supplyType, :delta,
      :deadline, :timeStamp, :version, :signer, :signature,
      :network

    alias mosaid_id mosaicId
    alias mosaid_id= mosaicId=
    alias supply_type supplyType
    alias supply_type= supplyType=
    alias timestamp timeStamp

    TYPE = 0x4002 # 16386 (mosaic supply change transaction)

    INCREASE = 0x0001
    DECREASE = 0x0002

    def initialize(mosaic_id, type, delta, network: :testnet)
      @type = TYPE
      @network = network

      @mosaicId = mosaic_id
      @supplyType = parse_type(type)
      @delta = delta
      @fee = Nis::Fee::MosaicSupplyChangeTransfer.new(self)
    end

    private

    def parse_type(type)
      case type
      when :increase  then INCREASE
      when :descrease then DECREASE
        else raise "Not implemented type: #{type}"
      end
    end
  end
end
