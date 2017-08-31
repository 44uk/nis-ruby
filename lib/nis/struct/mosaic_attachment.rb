class Nis::Struct
  # @attr [String] fqn ex) nem.xem
  # @attr [Integer] quantity
  # @see https://nemproject.github.io/#version-2-transfer-transactions
  class MosaicAttachment
    extend Forwardable
    def_delegators :@mosaic_definition, :initial_supply, :divisibility

    attr_reader :mosaic_definition, :quantity

    def initialize(mo_def, quantity)
      @mosaic_definition = mo_def
      @quantity = quantity
    end

    def to_hash
      { mosaicId: @mosaic_definition.id.to_hash,
        quantity: @quantity }
    end
  end
end
