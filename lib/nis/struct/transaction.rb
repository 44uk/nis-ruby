class Nis::Struct
  # @attr [Integer] timestamp
  # @attr [Integer] amount
  # @attr [Integer] fee
  # @attr [String]  recipient
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Nis::Struct::Message] message
  # @attr [Integer] version
  # @attr [String]  signer
  # @attr [Array <Nis::Struct::MosaicId>] mosaics
  # @see http://bob.nem.ninja/docs/#transaction
  # @see http://bob.nem.ninja/docs/#initiating-a-transfer-transaction
  # @see http://bob.nem.ninja/docs/#version-1-transfer-transactions
  # @see http://bob.nem.ninja/docs/#version-2-transfer-transactions
  class Transaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :amount, :fee, :recipient, :type, :deadline, :message, :version, :signer,
                  :mosaics

    alias :timestamp :timeStamp
    alias :timestamp= :timeStamp=

    TRANSFER = 0x0101                                 #   257 (transfer transaction)
    IMPORTANCE_TRANSFER = 0x0801                      #  2049 (importance transfer transaction)
    MULTISIG_AGGREGATE_MODIFICATION_TRANSFER = 0x1001 #  4097 (multisig aggregate modification transfer transaction)
    MULTISIG_SIGNATURE = 0x1002                       #  4098 (multisig signature transaction)
    MULTISIG = 0x1004                                 #  4099 (multisig transaction)
    PROVISION_NAMESPACE = 0x2001                      #  8193 (provision namespace transaction)
    MOSAIC_DEFINITION_CREATION = 0x4001               # 16385 (mosaic definition creation transaction)
    MOSAIC_SUPPLY_CHANGE = 0x4002                     # 16386 (mosaic supply change transaction)

    TESTNET = 0x98000000 # -1744830464
    MAINNET = 0x68000000 #  1744830464

    VERSION_1 = 0x00000001 # 1
    VERSION_2 = 0x00000002 # 2

    TESTNET_VERSION_1 = TESTNET | VERSION_1 # 0x98000001 = -1744830463
    TESTNET_VERSION_2 = TESTNET | VERSION_2 # 0x98000002 = -1744830462
    MAINNET_VERSION_1 = MAINNET | VERSION_1 # 0x68000001 =  1744830465
    MAINNET_VERSION_2 = MAINNET | VERSION_2 # 0x68000002 =  1744830466

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def _version
      (0xFFFFFFF0 & @version)
    end

    # @return [Boolean]
    def testnet?
      (0x0000000F & @version) == TESTNET
    end

    # @return [Boolean]
    def mainnet?
      (0x0000000F & @version) == MAINNET
    end

    # @return [Integer]
    def fee
      @fee ||= calculate_fee
    end

    def mosaics
      @mosaics ||= []
    end

    # @return [Integer]
    def calculate_fee
      if mosaics.empty?
        tmp_fee = [1, amount / 1_000_000 / 10000].max
        fee = (tmp_fee > 25 ? 25 : tmp_fee)
      else
        # TODO: calc mosaics fee
        raise NotImplementedError, 'not implemented calculation mosaic fee.'
        fee = 25
      end

      if message.bytesize > 0
        fee += [1, (message.bytesize / 2 / 32) + 1].max
      end

      fee * 1_000_000
    end
  end
end
