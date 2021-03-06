class Nis::Struct
  # @attr [String] creator
  # @attr [Nis::Struct::MosaicId] id
  # @attr [String] description
  # @attr [Nis::Struct::MosaicProperties] properties
  # @attr [Nis::Struct::MosaicLevy] levy
  # @see https://nemproject.github.io/#mosaicDefinition
  class MosaicDefinition
    include Nis::Util::Assignable
    attr_accessor :creator, :id, :description, :properties, :levy

    extend Forwardable
    def_delegators :@properties, :divisibility, :initialSupply, :supplyMutable, :transferable,
      :initial_supply, :supply_mutable

    def self.build(attrs)
      attrs[:id] = MosaicId.build(attrs[:id])
      attrs[:properties] = MosaicProperties.build(attrs[:properties])
      attrs[:levy] = MosaicLevy.build(attrs[:levy]) if attrs[:levy]
      new(attrs)
    end
  end
end
