class Nis::Struct
  # @attr [Integer] type
  # @attr [String] recipient
  # @attr [Nis::Struct::MosaicId] mosaicId
  # @attr [Integer] fee
  # @see http://bob.nem.ninja/docs/#mosaicLevy
  class MosaicLevy
    include Nis::Util::Assignable
    attr_accessor :type, :recipient, :mosaicId, :fee

    alias :mosaid_id :mosaicId

    def self.build(attrs)
      attrs[:mosaicId] = MosaicId.build(attrs[:mosaicId])
      new(attrs)
    end
  end
end
