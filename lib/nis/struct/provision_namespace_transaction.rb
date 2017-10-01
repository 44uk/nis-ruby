class Nis::Struct
  # @attr [String] rentalFeeSink
  # @attr [Integer] rentalFee
  # @attr [String] newPart
  # @attr [String] parent
  class ProvisionNamespaceTransaction < Transaction
    attr_accessor :rentalFeeSink, :rentalFee, :newPart, :parent

    alias :rental_fee_sink :rentalFeeSink
    alias :rental_fee_sink= :rentalFeeSink=
    alias :rental_fee :rentalFee
    alias :rental_fee= :rentalFee=
    alias :new_part :newPart
    alias :new_part= :newPart=
  end
end
