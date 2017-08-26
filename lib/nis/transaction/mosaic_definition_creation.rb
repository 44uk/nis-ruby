class Nis::Transaction
  # @attr [Nis::Struct::MosaicDefinition] mosaic_definition
  # @attr [Integer] creationFee
  # @attr [Integer] creationFeeSink
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @attr [Symbol] network
  # @attr [Nis::Struct::MosaicDefinition] mosaicDefinition
  # @see https://nemproject.github.io/#mosaicDefinitionCreationTransaction
  class MosaicDefinitionCreation
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :mosaicDefinition, :creationFee, :creationFeeSink,
      :deadline, :timeStamp, :version, :signer, :signature,
      :network

    alias mosaic_definition mosaicDefinition
    alias mosaic_definition= mosaicDefinition=
    alias creation_fee creationFee
    alias creation_fee_sink creationFeeSink
    alias timestamp timeStamp

    TYPE = 0x4001 # 16385 (mosaic definition creation transaction)

    def initialize(mosaic_definition, network: :testnet)
      @type = TYPE
      @network = network

      @mosaicDefinition = mosaic_definition
      @creationFee = creation[:fee]
      @creationFeeSink = creation[:sink]
      @fee = Nis::Fee::MosaicDefinitionCreation.new(self)
    end

    private

    # @see http://www.nem.ninja/docs/#mosaics
    def creation
      if @network == :testnet
        { sink: 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
          fee: 20 * 1_000_000 }
      else
        { sink: 'NBMOSAICOD4F54EE5CDMR23CCBGOAM2XSIUX6TRS',
          fee: 500 * 1_000_000 }
      end
    end
  end
end
