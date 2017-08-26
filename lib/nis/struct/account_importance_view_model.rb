class Nis::Struct
  # @attr [Nis::Unit::Address] address
  # @attr [Float] importance
  # @attr [Integer] isSet
  # @attr [Integer] score
  # @attr [Integer] ev
  # @attr [Integer] height
  # @see https://nemproject.github.io/#accountImportanceViewModel
  class AccountImportanceViewModel
    include Nis::Util::Assignable
    attr_accessor :address, :importance, :isSet, :score, :ev, :height

    alias :is_set :isSet
    alias :is_set= :isSet=

    def self.build(attrs)
      attrs[:address] = Nis::Unit::Address.new(attrs[:address])
      new(attrs)
    end

    # @return [Boolean]
    def set?
      @is_set == 1
    end
  end
end
