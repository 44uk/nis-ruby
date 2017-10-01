class Nis::Struct
  # @attr [Integer] type
  # @attr [Integer] version
  # @attr [Integer] timestamp
  # @attr [String]  signer
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @see https://nemproject.github.io/#transaction
  class Transaction
    include Nis::Util::Assignable
    attr_accessor :type, :version, :timeStamp, :signer, :fee, :deadline

    alias :timestamp :timeStamp
    alias :timestamp= :timeStamp=

    def self.build(attrs)
      new(attrs)
    end
  end
end
