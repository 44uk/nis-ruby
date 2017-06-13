class Nis::Struct
  # @attr [String] creator
  # @attr [Nis::Struct::MosaicId] id
  # @attr [String] description
  # @attr [Nis::Struct::MosaicProperties] properties
  # @attr [Nis::Struct::MosaicLevy] levy
  # @see http://bob.nem.ninja/docs/#mosaicDefinition
  class MosaicDefinition
    include Nis::Util::Assignable
    attr_accessor :creator, :id, :description, :properties, :levy

    def self.build(attrs)
      attrs[:id] = MosaicId.build(attrs[:id])
      attrs[:properties] = attrs[:properties].map { |p| MosaicProperties.build(p) }
      attrs[:levy] = MosaicLevy.build(attrs[:levy]) if attrs[:levy]
      new(attrs)
    end
  end
end
