class Nis::Transaction
  # @attr [String] newPart
  # @attr [String] parent
  # @attr [Integer] rentalFee
  # @attr [String] rentalFeeSink
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @attr [Symbol] network
  # @see https://nemproject.github.io/#provisionNamespaceTransaction
  class ProvisionNamespace
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :newPart, :parent, :rentalFeeSink, :rentalFee,
      :deadline, :timeStamp, :version, :signer, :signature,
      :network

    alias new_part newPart
    alias new_part= newPart=
    alias rental_fee rentalFee
    alias rental_fee= rentalFee=
    alias rental_fee_sink rentalFeeSink
    alias rental_fee_sink= rentalFeeSink=
    alias timestamp timeStamp

    TYPE = 0x2001 # 8193 (provision namespace transaction)

    def initialize(new_part, parent = nil, network: :testnet)
      @type = TYPE
      @network = network

      @newPart = new_part
      @parent = parent
      @rentalFee = rental[:fee]
      @rentalFeeSink = rental[:sink]

      @fee = Nis::Fee::ProvisionNamespace.new(self)
    end

    def root?
      !!(@parent == nil)
    end

    def sub?
      !!(@parent && @newPart)
    end

    private

    # @see http://www.nem.ninja/docs/#namespaces
    def rental
      if @network == :testnet
        if root?
          { fee: 100 * 1_000_000,
            sink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35' }
        else
          { fee: 10 * 1_000_000,
            sink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35' }
        end
      else
        if root?
          { fee: 5_000 * 1_000_000 ,
            sink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA' }
        else
          { fee: 200 * 1_000_000 ,
            sink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA' }
        end
      end
    end
  end
end
