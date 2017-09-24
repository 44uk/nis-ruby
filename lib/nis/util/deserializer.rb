module Nis::Util
  module Deserializer
    # Deserialize a transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_transaction(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      type = deserialize_int(s[0, 4])
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
      method.call(serialized)
    end

    # Deserialize a transfer transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_transfer(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # s[60,4] # length of  address
      tx[:recipient] = deserialize_a(s[64, 40])
      tx[:amount] = deserialize_int(s[104, 8])
      tx[:message] = {}
      message_len = deserialize_int(s[112, 4])
      if message_len > 0
        tx[:message][:type] = deserialize_int(s[116, 4])
        # s[120, 4] # length of payload
        tx[:message][:payload] = deserialize_hex(s[124, s.size])
      else
        tx[:message] = { type: 1, payload: '' }
      end
      common.merge(tx)
    end

    # Deserialize a importance transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_importance_transfer(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      tx[:mode] = deserialize_int(s[60, 4])
      # s[64, 4] # Length of remote account public key byte array
      tx[:remoteAccount] = deserialize_hex(s[68, 32])
      common.merge(tx)
    end

    # Deserialize a multisig aggregate modification transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig_aggregate_modification(serialized)
      raise 'Not yet implimented.'
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # TODO: deserializing
      common.merge(tx)
    end

    # Deserialize a multisig signature transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig_signature(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      tx[:otherHash] = { data: deserialize_hex(s[68, 32]) }
      tx[:otherAccount] = deserialize_a(s[104, 40])
      common.merge(tx)
    end

    # Deserialize a multisig transfer transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_multisig(serialized)
      raise 'Not yet implimented.'
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # TODO: deserializing
      common.merge(tx)
    end

    # Deserialize a provision namespace transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_provision_namespace(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # s[60, 4] # Length of rental fee sink's public key byte array (always 32): 4 bytes
      tx[:rentalFeeSink] = deserialize_a(s[64, 40]) # Public key bytes of rental fee sink
      tx[:rentalFee] = deserialize_int(s[104, 8]) # Fental fee: 8 bytes
      newpart_len = deserialize_int(s[112, 4]) # Length of new part string: 4 bytes
      tx[:newPart] = deserialize_a(s[116, newpart_len]) # New part string: UTF8 encoded string.
      parent_len = deserialize_int(s[116 + newpart_len, 4]) # Length of parent string: 4 bytes
      parent = s[116 + newpart_len, parent_len]
      unless parent.all? { |val| val == 0xff }
        tx[:parent] = deserialize_a(parent) # Parent string: UTF8 encoded string
      end
      common.merge(tx)
    end

    # Deserialize a mosaic definition creation transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_mosaic_definition_creation(serialized)
      raise 'Not yet implimented.'
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # TODO: deserializing
      common.merge(tx)
    end

    # Deserialize a mosaic supply change transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_mosaic_supply_change(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      common = deserialize_common(s)
      tx = {}
      # s[60, 4] # Length of mosaic id structure
      ns_len = deserialize_int(s[64, 4]) # Length of namespace id string
      mo_len = deserialize_int(s[68 + ns_len, 4]) # Length of mosaic name string
      tx[:mosaicId] = {
        namespaceId: deserialize_a(s[68, ns_len]),
        name: deserialize_a(s[68 + ns_len + mo_len, mo_len])
      }
      tx[:supplyType] = deserialize_int(s[68 + ns_len + 4 + mo_len, 4]) # Supply type
      tx[:delta] = deserialize_int(s[68 + ns_len + 4 + mo_len + 4, 8]) # Delta (change in supply)
      common.merge(tx)
    end

    private

    def self.deserialize_common(s)
      tx = {}
      tx[:type] = deserialize_int(s[0, 4])
      tx[:version] = deserialize_int(s[4, 4])
      tx[:timeStamp] = deserialize_int(s[8, 4])
      # s[12,4] # length of public key
      tx[:signer] = deserialize_hex(s[16, 32])
      tx[:fee] = deserialize_int(s[48, 8])
      tx[:deadline] = deserialize_int(s[56, 4])
      tx
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
