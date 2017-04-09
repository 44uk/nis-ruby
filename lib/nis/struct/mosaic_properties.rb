class Nis::Struct
  # @attr [Array] properties
  # @attr [Integer] divisibility
  # @attr [Integer] initial_supply
  # @attr [Boolean] supply_mutable
  # @attr [Boolean] transferable
  # @see http://bob.nem.ninja/docs/#mosaicProperties
  class MosaicProperties
    include Nis::Util::Assignable
    attr_accessor :divisibility, :initial_supply, :supply_mutable, :transferable

    def self.build(attrs)
      new(attrs)
    end

    # @return [Boolean]
    def supply_mutable?
      @supply_mutable == 'true'
    end

    # @return [Boolean]
    def transferable?
      @transferable == 'true'
    end
  end
end
