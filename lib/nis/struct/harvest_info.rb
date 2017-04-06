class Nis::Struct
  # @attr [Integer] timestamp
  # @attr [String] id
  # @attr [Integer] difficulty
  # @attr [Integer] total_fee
  # @attr [Integer] height
  # @see http://bob.nem.ninja/docs/#harvestInfo
  class HarvestInfo
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :id, :difficulty, :totalFee, :height

    alias :timestamp :timeStamp
    alias :timestamp= :timeStamp=
    alias :total_fee :totalFee
    alias :total_fee= :totalFee=

    def self.build(attrs)
      new(attrs)
    end
  end
end
