class Nis::Request
  # @attr [String] data
  # @attr [String] signature
  # @see https://nemproject.github.io/#requestAnnounce
  class Announce
    include Nis::Mixin::Struct

    attr_accessor :transaction, :keypair, :data, :signature

    DEADLINE = 3600

    def initialize(transaction, keypair)
      @keypair = keypair
      @transaction = transaction
    end

    # @return [Hash] Attribute and value pairs
    def to_hash
      if @transaction.respond_to?(:other_trans)
        other_trans(@transaction)
      end

      @transaction.tap do |tx|
        tx.timeStamp = Nis::Util.timestamp
        tx.deadline = Nis::Util.deadline(DEADLINE)
        tx.version = Nis::Util.parse_version(tx.network, version(tx))
        tx.signer = @keypair.public
      end

      serialized = serialize(@transaction)
      hex_serialized = Nis::Util::Convert.ua2hex(serialized)

      { data: Nis::Util::Convert.ua2hex(serialized),
        signature: signature(hex_serialized) }
    end

    private

    def serialize(transaction)
      Nis::Util::Serializer.serialize_transaction(transaction.to_hash)
    end

    def signature(serialized)
      @keypair.sign(serialized)
    end

    def other_trans(transaction)
      transaction.other_trans.tap do |tx|
        tx.timeStamp = Nis::Util.timestamp
        tx.deadline = Nis::Util.deadline(DEADLINE)
        tx.version = Nis::Util.parse_version(tx.network, version(tx))
        tx.signer = transaction.signer
      end
    end

    def version(transaction)
      transaction.respond_to?(:has_mosaics?) && transaction.has_mosaics? ? 2 : 1
    end
  end
end
