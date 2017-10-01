class Nis::Struct
  # @attr [String] mosaicId
  # @attr [Integer] supplyType
  # @attr [Integer] delta
  class MosaicSupplyChangeTransaction < Transaction
    attr_accessor :mosaicId, :supplyType, :delta

    # def self.build
    # TODO: mosaicId
    # end
  end
end
