class Nis::Struct
  # @attr [String] mosaicId
  # @attr [String] name
  # @see http://bob.nem.ninja/docs/#mosaicId
  class MosaicId
    include Nis::Util::Assignable
    attr_accessor :type, :recipient, :mosaicId, :fee

    alias :mosaic_id :mosaicId
    alias :mosaic_id= :mosaicId=

    def self.build(attrs)
      new(attrs)
    end
  end
end
