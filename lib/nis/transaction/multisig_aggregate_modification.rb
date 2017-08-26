class Nis::Transaction
  # @attr [Array <Nis::Struct::MultisigCosignatoryModification>] modifications
  # @attr [Interger] min_cosigs
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @see https://nemproject.github.io/#multisigAggregateModificationTransaction
  class MultisigAggregateModification
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :modifications, :minCosignatories,
      :deadline, :timeStamp, :version, :signer, :signature,
      :network

    alias min_cosignatories minCosignatories
    alias min_cosignatories= minCosignatories=
    alias timestamp timeStamp

    TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)

    def initialize(modifications, min_cosigs, network: :testnet)
      @type = TYPE
      @network = network

      @modifications = modifications
      @minCosignatories = min_cosigs
      # @minCosignatories = { relativeChange: 1 }
      @fee = Nis::Fee::MultisigAggregateModification.new(self)
    end

    private

    # def relative_change
    #   modifications.inject do |sum, mod|
    #     case mod.modificationType
    #     when :add    then  1
    #     when :remove then -1
    #       else raise "Unsupported modificationType: #{mod.modificationType}"
    #     end
    #   end
    # end
  end
end
