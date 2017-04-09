class Nis::Struct
  # @attr [Nis::Struct::MosaicId] mosaicId
  # @attr [Integer] quantity
  # @see http://bob.nem.ninja/docs/#mosaic
  class Mosaic
    include Nis::Util::Assignable
    attr_accessor :mosaicId, :quantity

    alias :mosaic_id :mosaicId
    alias :mosaic_id= :mosaicId=

    def self.build(attrs)
      attrs[:mosaicId] = Nis::Struct::MosaicId.build attrs[:mosaicId]
      new(attrs)
    end
  end
end
