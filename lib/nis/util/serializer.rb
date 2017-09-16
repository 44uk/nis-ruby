module Nis::Util
  module Serializer
    # Serialize a transaction object
    # @param [Hash] entity
    # @return [Array]
    def self.serialize_transaction(entity)
      method = case entity[:type]
               when 0x0101 then method(:serialize_transfer)
               when 0x0801 then method(:serialize_importance_transfer)
               when 0x1001 then method(:serialize_multisig_aggregate_modification)
               when 0x1002 then method(:serialize_multisig_signature)
               when 0x1004 then method(:serialize_multisig)
               when 0x2001 then method(:serialize_provision_namespace)
               when 0x4001 then method(:serialize_mosaic_definition_creation)
               when 0x4002 then method(:serialize_mosaic_supply_change)
        else raise "Not implemented entity type: #{entity[:type]}"
      end
      method.call(entity)
    end

    def self.serialize_transfer(entity)
      a = []
      # Common transaction part
      a += serialize_common(entity)
      # Transfer transaction part
      a += serialize_safe_string(entity[:recipient])
      a += serialize_long(entity[:amount])
      temp = hex2ua(entity[:message][:payload])
      if temp.size == 0
        a += [0, 0, 0, 0]
      else
        a += serialize_int(temp.size + 8)
        a += serialize_int(entity[:message][:type])
        a += serialize_int(temp.size)
        a += temp
      end
      a
    end

    def self.serialize_importance_transfer(entity)
      a = []
      a += serialize_common(entity)
      a += serialize_int(entity[:mode])
      temp = hex2ua(entity[:remoteAccount])
      a += serialize_int(temp.size)
      a += temp
      a
    end

    def self.serialize_multisig_aggregate_modification(entity)
      a = []
      a += serialize_common(entity)
      a += serialize_int(entity[:modifications].size)
      a += entity[:modifications].map do |mod|
        b = []
        b += serialize_int(40)
        b += serialize_int(mod[:modificationType])
        b += serialize_int(32)
        b += hex2ua(mod[:cosignatoryAccount])
        b
      end.flatten

      # The following part describes the minimum cosignatories modification.
      # The part is optional. Version 1 aggregate modification transactions should omit this part.
      # Version 2 aggregate modification transactions with no minimum cosignatories modification
      # should only write the length field with value 0x00, 0x00, 0x00, 0x00.
      if true # only version2
        if entity[:minCosignatories][:relativeChange] > 0
          a += serialize_int(4)
          a += serialize_int(entity[:minCosignatories][:relativeChange])
        else
          a += [0, 0, 0, 0]
        end
      end
      a
    end

    def self.serialize_multisig_signature(entity)
      a = []
      a += serialize_common(entity)
      temp = hex2ua(entity[:otherHash][:data])
      a += serialize_int(4 + temp.size)
      a += serialize_int(temp.size)
      a += temp
      a += serialize_safe_string(entity[:otherAccount])
    end

    def self.serialize_multisig(entity)
      a = []
      a += serialize_common(entity)
      other_tx = entity[:otherTrans]
      tx = case other_tx[:type]
        when 0x0101 then serialize_transfer(other_tx)
        when 0x0801 then serialize_importance_transfer(other_tx)
        when 0x1001 then serialize_multisig_aggregate_modification(other_tx)
        else raise "Unexpected type #{other_tx[:type]}"
      end
      a += serialize_int(tx.size)
      a += tx
      a
    end

    def self.serialize_provision_namespace(entity)
      a = []
      a += serialize_common(entity)
      a += serialize_safe_string(entity[:rentalFeeSink])
      a += serialize_long(entity[:rentalFee])
      temp = hex2ua(utf8_to_hex(entity[:newPart]))
      a += serialize_int(temp.size)
      a += temp
      if entity[:parent]
        temp = hex2ua(utf8_to_hex(entity[:parent]))
        a += serialize_int(temp.size)
        a += temp
      else
        a += [255, 255, 255, 255]
      end
      a
    end

    def self.serialize_mosaic_definition_creation(entity)
      a = []
      a += serialize_common(entity)
      a += serialize_mosaic_definition(entity[:mosaicDefinition])
      a += serialize_safe_string(entity[:creationFeeSink])
      a += serialize_long(entity[:creationFee])
      a
    end

    def self.serialize_mosaic_supply_change(entity)
      a = []
      a += serialize_common(entity)
      mo_id = entity[:mosaicId]
      a_ns = hex2ua(utf8_to_hex(mo_id[:namespaceId]))
      a_ns_len = serialize_int(a_ns.size)
      a_mo = hex2ua(utf8_to_hex(mo_id[:name]))
      a_mo_len = serialize_int(a_mo.size)
      a += serialize_int((a_ns_len + a_ns + a_mo_len + a_mo).size)
      a += a_ns_len
      a += a_ns
      a += a_mo_len
      a += a_mo
      a += serialize_int(entity[:supplyType])
      a += serialize_long(entity[:delta])
      a
    end

    private

    def self.serialize_common(entity)
      a = []
      a += serialize_int(entity[:type])
      a += serialize_int(entity[:version])
      a += serialize_int(entity[:timeStamp])

      temp = hex2ua(entity[:signer])
      a += serialize_int(temp.size)
      a += temp

      a += serialize_long(entity[:fee].to_i)
      a += serialize_int(entity[:deadline])
      a
    end

    # Safe String - Each char is 8 bit
    # @param [String] str
    # @return [Array]
    def self.serialize_safe_string(str)
      return [].fill(255, 0, 4) if str.nil?
      return [].fill(0, 0, 4) if str.empty?
      [str.size, 0, 0, 0] + str.bytes
    end

    # @param [String] str
    # @return [Array]
    def self.serialize_bin_string(str)
      return [].fill(255, 0, 4) if str.nil?
      return [].fill(0, 0, 4) if str.empty?
      chars = str.is_a?(String) ? str.chars : str
      [chars.size, 0, 0, 0] + chars.map(&:to_i)
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_int(value)
      a = [].fill(0, 0, 4)
      bin = sprintf('%032b', [value].pack('L').unpack('L')[0])
      0.upto(bin.size / 8 - 1) do |i|
        a[i] = 0xFF & (value >> 8 * i)
      end
      a
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_long(value)
      a = [].fill(0, 0, 8)
      bin = sprintf('%040b', [value].pack('L').unpack('L')[0])
      0.upto(bin.size / 8 - 1) do |i|
        a[i] = 0xFF & (value >> 8 * i)
      end
      a
    end

    # @param [Nis::Struct::Mosaic] mosaic
    # @return [Array]
    def self.serialize_mosaic_and_quantity(mosaic)
      a = [].fill(0, 0, 4)
      serialized_mosaic_id = serialize_mosaic_id(mosaic.mosaic_id)
      serialized_quantity = serialize_long(mosaic.quantity)
      a[0] = serialized_mosaic_id.size + serialized_quantity.size
      a += serialized_mosaic_id + serialized_quantity
    end

    # @param [Array <Nis::Struct::Mosaic>] entities
    # @return [Array]
    def self.serialize_mosaics(entities)
      a = [].fill(0, 0, 4)
      a[0] = entities.size
      a + entities.map do |ent|
        { entity: ent,
          value: [
            ent.mosaic_id.namespace_id,
            ent.mosaic_id.name,
            ent.quantity,
          ].join(':') }
      end.sort_by do |ent|
        ent[:value]
      end.map do |ent|
        serialize_mosaic_and_quantity(ent[:entity])
      end.flatten
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_mosaic_id(entity)
      a = []
      a += serialize_safe_string(entity[:namespaceId])
      a += serialize_safe_string(entity[:name])
      serialize_int(a.size) + a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_property(entity)
      a = []
      a += serialize_safe_string(entity[:name])
      a += serialize_safe_string(entity[:value])
      serialize_int(a.size) + a
    end

    # @param [Array] entities
    # @return [Array]
    def self.serialize_properties(entities)
      order = {
        'divisibility'  => 1,
        'initialSupply' => 2,
        'supplyMutable' => 3,
        'transferable'  => 4
      }
      a = []
      a = entities.sort_by { |ent| order[ent[:name]] }
        .map { |ent| serialize_property(ent) }.flatten
      serialize_int(entities.size) + a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_levy(entity)
      return [0, 0, 0, 0] if entity.nil?
      a = []
      a += serialize_int(entity[:type])
      a += serialize_safe_string(entity[:recipient])
      a += serialize_mosaic_id(entity[:mosaicId])
      a += serialize_long(entity[:fee])
      serialize_int(a.size) + a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_mosaic_definition(entity)
      a = []
      temp = hex2ua(entity[:creator])
      a += serialize_int(temp.size)
      a += temp
      a += serialize_mosaic_id(entity[:id])
      a += serialize_bin_string(hex2ua(utf8_to_hex(entity[:description])))
      a += serialize_properties(entity[:properties])
      a += serialize_levy(entity[:levy])
      serialize_int(a.size) + a
    end

    # @param [String] hex
    # @return [Array]
    def self.hex2ua(hex)
      hex.scan(/../).map(&:hex)
    end

    # @param [String] hex
    # @return [Array]
    def self.hex2ua_reversed(hex)
      hex2ua(hex).reverse
    end

    # @param [Array] bin
    # @return [String]
    def self.bin2hex(bin)
      bin.map { |v| '%02x' % v }.join
    end

    # @param [String] str
    # @return [String]
    def self.utf8_to_hex(str)
      rstr2utf8(str).each_byte.map { |b| b.to_s(16) }.join
    end

    # @param [String] str
    # @return [String]
    def self.rstr2utf8(str)
      str.unpack('U*').map do |c|
        case
        when c < 128
          c
        when 128 < c && c < 2048
          [((c >> 6) | 192), ((c & 63) | 128)]
        else
          [((c >> 12) | 224), (((c >> 6) & 63) | 128), ((c & 63) | 128)]
        end
      end.flatten.map(&:chr).join
    end
  end
end
