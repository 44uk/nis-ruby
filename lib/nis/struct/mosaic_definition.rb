class Nis::Struct
  # @attr [String] creator
  # @attr [String] id
  # @attr [String] description
  # @attr [Nis::Struct::MosaicProperties] properties
  # @attr [Nis::Struct::MosaicLevy] levy
  # @see http://bob.nem.ninja/docs/#mosaicDefinition
  class MosaicDefinition
    include Nis::Util::Assignable
    attr_accessor :creator, :id, :description, :properties, :levy

    def self.build(attrs)
      attrs[:properties] = attrs[:properties].map { |p| MosaicProperties.build(p) }
      new(attrs)
    end
  end
end
