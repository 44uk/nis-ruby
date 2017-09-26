module Nis::Util
  module Deserializer
    # Deserialize a transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_transaction(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = s[0, 60]
      specific = s[60, s.size]
      type = deserialize_int(common[0, 4])
      method = case type
               when 0x0101 then method(:deserialize_transfer)
               when 0x0801 then method(:deserialize_importance_transfer)
               when 0x1001 then method(:deserialize_multisig_aggregate_modification)
               when 0x1002 then method(:deserialize_multisig_signature)
               when 0x1004 then method(:deserialize_multisig)
               when 0x2001 then method(:deserialize_provision_namespace)
               when 0x4001 then method(:deserialize_mosaic_definition_creation)
               when 0x4002 then method(:deserialize_mosaic_supply_change)
        else raise "Not implemented entity type: #{type}"
      end
      deserialize_common(common).merge(method.call(specific))
    end

    private

    # Deserialize a transfer transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_transfer(s)
      tx = {}
      tx[:recipient] = deserialize_a(s[4, 40])
      tx[:amount] = deserialize_int(s[44, 8])
      tx[:message] = {}
      message_len = deserialize_int(s[52, 4])
      if message_len > 0
        # s[60, 4] # length of payload
        tx[:message] = {
          type: deserialize_int(s[56, 4]),
          payload: deserialize_hex(s[64, s.size])
        }
      else
        tx[:message] = { type: 1, payload: '' }
      end
      tx
    end

    # Deserialize a importance transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_importance_transfer(s)
      {
        mode: deserialize_int(s[0, 4]),
        remoteAccount: deserialize_hex(s[8, 32])
      }
    end

    # Deserialize a multisig aggregate modification transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig_aggregate_modification(s)
      raise 'Not yet implimented.'
      # TODO: deserializing
      tx = {}
      tx
    end

    # Deserialize a multisig signature transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig_signature(s)
      {
        otherHash: { data: deserialize_hex(s[8, 32]) },
        otherAccount: deserialize_a(s[44, 40])
      }
    end

    # Deserialize a multisig transfer transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig(s)
      raise 'Not yet implimented.'
      # TODO: deserializing
      tx = {}
      tx
    end

    # Deserialize a provision namespace transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_provision_namespace(s)
      tx = {}
      tx[:rentalFeeSink] = deserialize_a(s[4, 40])
      tx[:rentalFee] = deserialize_int(s[44, 8])
      newpart_len = deserialize_int(s[52, 4])
      tx[:newPart] = deserialize_a(s[56, newpart_len])
      parent_len = deserialize_int(s[56 + newpart_len, 4])
      parent = s[56 + newpart_len, parent_len]
      unless parent.all? { |val| val == 0xff }
        tx[:parent] = deserialize_a(parent)
      end
      tx
    end

    # Deserialize a mosaic definition creation transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_mosaic_definition_creation(s)
      raise 'Not yet implimented.'
      # TODO: deserializing
      tx = {}
      tx
    end

    # Deserialize a mosaic supply change transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_mosaic_supply_change(s)
      tx = {}
      # s[0, 4] # Length of mosaic id structure
      ns_len = deserialize_int(s[4, 4])
      mo_len = deserialize_int(s[8 + ns_len, 4])
      tx[:mosaicId] = {
        namespaceId: deserialize_a(s[8, ns_len]),
        name: deserialize_a(s[8 + ns_len + mo_len, mo_len])
      }
      tx[:supplyType] = deserialize_int(s[8 + ns_len + 4 + mo_len, 4])
      tx[:delta] = deserialize_int(s[8 + ns_len + 4 + mo_len + 4, 8])
      tx
    end

    def self.deserialize_common(s)
      {
        type: deserialize_int(s[0, 4]),
        version: deserialize_int(s[4, 4]),
        timeStamp: deserialize_int(s[8, 4]),
        # s[12,4] # length of public key,
        signer: deserialize_hex(s[16, 32]),
        fee: deserialize_int(s[48, 8]),
        deadline: deserialize_int(s[56, 4])
      }
    end

    def self.deserialize_int(ua)
      Nis::Util::Convert.ua2hex(ua.reverse).to_i(16)
    end

    def self.deserialize_hex(ua)
      Nis::Util::Convert.ua2hex(ua)
    end

    def self.deserialize_a(ua)
      Nis::Util::Convert.hex2a(deserialize_hex(ua))
    end
  end
end
