class Nis::Struct
  # @attr [Integer] divisibility
  # @attr [Integer] initialSupply
  # @attr [Boolean] supplyMutable
  # @attr [Boolean] transferable
  # @see https://nemproject.github.io/#mosaicProperties
  class MosaicProperties
    include Nis::Util::Assignable
    attr_accessor :divisibility, :initialSupply, :supplyMutable, :transferable

    alias initial_supply initialSupply
    alias initial_supply= initialSupply=
    alias supply_mutable supplyMutable
    alias supply_mutable= supplyMutable=

    def self.build(props)
      attrs = props.inject({}) do |hash, prop|
        hash[prop[:name]] = case prop[:name]
          when 'divisibility'  then prop[:value].to_i
          when 'initialSupply' then prop[:value].to_i
          when 'supplyMutable' then prop[:value] == 'true' ? true : false
          when 'transferable'  then prop[:value] == 'true' ? true : false
          else prop[:value]
        end
        hash
      end
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
        value: supply_mutable.to_s
      }, {
        name: 'transferable',
        value: transferable.to_s
      }]
    end
  end
end
