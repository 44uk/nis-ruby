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
      entity = @transaction.clone

      entity.amount *= 1_000_000 if entity.respond_to?(:amount)

      if entity.respond_to?(:other_trans)
        other_trans(entity)
      end

      entity.tap do |tx|
        tx.timeStamp = Nis::Util.timestamp
        tx.deadline = Nis::Util.deadline(DEADLINE)
        tx.version = Nis::Util.parse_version(tx.network, version(tx))
        tx.signer = @keypair.public
      end

      entity_hash = entity.to_hash
      if entity.respond_to?(:has_mosaics?) && !entity.has_mosaics?
        entity_hash.delete(:mosaics)
      end

      if entity.respond_to?(:other_trans) && !entity.other_trans.has_mosaics?
        entity_hash[:otherTrans].delete(:mosaics)
      end

      serialized = serialize(entity_hash)
      hex_serialized = Nis::Util::Convert.ua2hex(serialized)

      { data: Nis::Util::Convert.ua2hex(serialized),
        signature: signature(hex_serialized) }
    end

    private

    def serialize(transaction_hash)
      Nis::Util::Serializer.serialize_transaction(transaction_hash)
    end

    def signature(serialized)
      @keypair.sign(serialized)
    end

    def other_trans(transaction)
      transaction.other_trans.tap do |tx|
        tx.amount *= 1_000_000 if tx.respond_to?(:amount)

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
