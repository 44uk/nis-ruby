class Nis::Struct
  # @attr [Integer] divisibility
  # @attr [Integer] initialSupply
  # @attr [Boolean] supplyMutable
  # @attr [Boolean] transferable
  # @see http://bob.nem.ninja/docs/#mosaicProperties
  class MosaicProperties
    include Nis::Util::Assignable
    attr_accessor :divisibility, :initialSupply, :supplyMutable, :transferable

    alias initial_supply initialSupply
    alias initial_supply= initialSupply=
    alias supply_mutable supplyMutable
    alias supply_mutable= supplyMutable=

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

    def to_hash
      [{
        name: 'divisibility',
        value: divisibility.to_s
      }, {
        name: 'initialSupply',
        value: initial_supply.to_s
      }, {
        name: 'supplyMutable',
        value: supply_mutable ? 'true' : 'false'
      }, {
        name: 'transferable',
        value: transferable ? 'true' : 'false'
      }]
    end
  end
end
