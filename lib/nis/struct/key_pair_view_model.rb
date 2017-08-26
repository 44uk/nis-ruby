class Nis::Struct
  # @attr [String] privateKey
  # @attr [String] publicKey
  # @attr [Nis::Unit::Address] address
  # @see https://nemproject.github.io/#keyPairViewModel
  class KeyPairViewModel
    include Nis::Util::Assignable
    attr_accessor :privateKey, :publicKey, :address

    alias :private_key :privateKey
    alias :private_key= :privateKey=
    alias :public_key :publicKey
    alias :public_key= :publicKey=

    def self.build(attrs)
      attrs[:address] = Nis::Unit::Address.new(attrs[:address])
      new(attrs)
    end
  end
end
