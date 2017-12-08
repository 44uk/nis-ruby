class Nis::Struct
  # @attr [Nis::Struct::MosaicId] id
  # @attr [Integer] supply
  # @see https://nemproject.github.io/#
  class MosaicSupply
    include Nis::Util::Assignable
    attr_accessor :mosaicId, :supply

    def self.build(attrs)
      attrs[:mosaicId] = MosaicId.build(attrs[:mosaicId])
      new(attrs)
    end
  end
end
