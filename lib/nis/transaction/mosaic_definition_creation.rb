class Nis::Transaction
  # @attr [Integer] timeStamp
  # @attr [Integer] signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Integer] creationFee
  # @attr [Integer] creationFeeSink
  # @attr [Nis::Struct::MosaicDefinition] mosaicDefinition
  # @see http://bob.nem.ninja/docs/#mosaicDefinitionCreationTransaction
  class MosaicDefinitionCreation
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :type, :deadline, :signer,
      :creationFee, :creationFeeSink, :mosaicDefinition

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias creation_fee creationFee
    alias creation_fee= creationFee=
    alias creation_feeSink creationFeeSink
    alias creation_feeSink= creationFeeSink=
    alias mosaic_definition mosaicDefinition
    alias mosaic_definition= mosaicDefinition=

    TYPE = 0x4001 # 16385 (mosaic definition creation transaction)
    FEE  = 20_000_000

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def type
      TYPE
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
