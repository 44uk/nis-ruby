class Nis::Transaction
  # @attr [String]  otherHash
  # @attr [String]  otherAccount
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @see https://nemproject.github.io/#multisigSignatureTransaction
  class MultisigSignature
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :otherHash, :otherAccount, :signer,
      :deadline, :timeStamp, :version, :signature,
      :network

    alias other_hash otherHash
    alias other_hash= otherHash=
    alias other_account otherAccount
    alias other_account= otherAccount=
    alias timestamp timeStamp

    TYPE = 0x1002 # 4098 (multisig signature transaction)

    def initialize(other_hash, other_account, signer, network: :testnet)
      @type = TYPE
      @network = network

      @otherHash = { data: other_hash }
      @otherAccount = other_account
      @signer = signer
      @fee = Nis::Fee::Multisig.new(self)
    end

    def otherHash=(hash)
      @otherHash = { data: hash }
    end

    def otherHash
      @otherHash[:data]
    end
  end
end
