class Nis::Request
  # @attr [Nis::Struct::Transaction] transaction
  # @attr [Nis::Keypair] keypair
  # @see https://nemproject.github.io/#requestPrepareAnnounce
  class PrepareAnnounce
    include Nis::Mixin::Struct

    attr_accessor :transaction, :keypair

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

      { transaction: entity_hash,
        privateKey: @keypair.private }
    end

    private

    def other_trans(transaction)
      transaction.other_trans.tap do |tx|
        tx.amount *= 1_000_000 if tx.respond_to?(:amount)

        tx.timeStamp = Nis::Util.timestamp
        tx.deadline = Nis::Util.deadline(DEADLINE)
        tx.version = Nis::Util.parse_version(tx.network, version(tx))

        # multisig transfer
        tx.signer = transaction.signer
      end
    end

    def version(transaction)
      transaction.respond_to?(:has_mosaics?) && transaction.has_mosaics? ? 2 : 1
    end
  end
end
