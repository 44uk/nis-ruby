class Nis::Struct
  # @attr [Hash] mosaicDefinition
  # @attr [String] creationFeeSink
  # @attr [Integer] creationFee
  class MosaicDefinitionCreationTransaction < Transaction
    attr_accessor :mosaicDefinition, :creationFeeSink, :creationFee

    alias :mosaic_definition :mosaicDefinition
    alias :mosaic_definition= :mosaicDefinition=
    alias :creation_fee_sink :creationFeeSink
    alias :creation_fee_sink= :creationFeeSink=
    alias :creation_fee :creationFee
    alias :creation_fee= :creationFee=
  end
end
