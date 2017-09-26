module Nis::Util
  module Serializer
    # Serialize a transaction object
    # @param [Hash] entity
    # @return [Array]
    def self.serialize_transaction(entity)
      specific = case entity[:type]
                 when 0x0101 then serialize_transfer(entity)
                 when 0x0801 then serialize_importance_transfer(entity)
                 when 0x1001 then serialize_multisig_aggregate_modification(entity)
                 when 0x1002 then serialize_multisig_signature(entity)
                 when 0x1004 then serialize_multisig(entity)
                 when 0x2001 then serialize_provision_namespace(entity)
                 when 0x4001 then serialize_mosaic_definition_creation(entity)
                 when 0x4002 then serialize_mosaic_supply_change(entity)
        else raise "Not implemented entity type: #{entity[:type]}"
      end
      serialize_common(entity) + specific
    end

    private

    def self.serialize_transfer(entity)
      a = []
      a.concat serialize_safe_string(entity[:recipient])
      a.concat serialize_long(entity[:amount])
      payload = Nis::Util::Convert.hex2ua(entity[:message][:payload])
      if payload.size == 0
        a.concat [0, 0, 0, 0]
      else
        a.concat serialize_int(payload.size + 8)
        a.concat serialize_int(entity[:message][:type])
        a.concat serialize_int(payload.size)
        a.concat payload
      end
      a
    end

    def self.serialize_importance_transfer(entity)
      a = []
      a.concat serialize_int(entity[:mode])
      temp = Nis::Util::Convert.hex2ua(entity[:remoteAccount])
      a.concat serialize_int(temp.size)
      a.concat temp
    end

    def self.serialize_multisig_aggregate_modification(entity)
      a = []
      a.concat serialize_int(entity[:modifications].size)
      mods = entity[:modifications].inject([]) do |b, mod|
        b.concat serialize_int(40)
        b.concat serialize_int(mod[:modificationType])
        b.concat serialize_int(32)
        b.concat Nis::Util::Convert.hex2ua(mod[:cosignatoryAccount])
        b
      end
      a.concat mods

      # The following part describes the minimum cosignatories modification.
      # The part is optional. Version 1 aggregate modification transactions should omit this part.
      # Version 2 aggregate modification transactions with no minimum cosignatories modification
      # should only write the length field with value 0x00, 0x00, 0x00, 0x00.
      if true # only version2
        if entity[:minCosignatories][:relativeChange] > 0
          a.concat serialize_int(4)
          a.concat serialize_int(entity[:minCosignatories][:relativeChange])
        else
          a.concat [0, 0, 0, 0]
        end
      end
      a
    end

    def self.serialize_multisig_signature(entity)
      a = []
      temp = Nis::Util::Convert.hex2ua(entity[:otherHash][:data])
      a.concat serialize_int(4 + temp.size)
      a.concat serialize_int(temp.size)
      a.concat temp
      a.concat serialize_safe_string(entity[:otherAccount])
      a
    end

    def self.serialize_multisig(entity)
      a = []
      other = entity[:otherTrans]
      tx = case other[:type]
           when 0x0101 then serialize_transfer(other)
           when 0x0801 then serialize_importance_transfer(other)
           when 0x1001 then serialize_multisig_aggregate_modification(other)
        else raise "Unexpected type #{other_tx[:type]}"
      end
      tx = serialize_common(other) + tx
      a.concat serialize_int(tx.size)
      a.concat tx
      a
    end

    def self.serialize_provision_namespace(entity)
      a = []
      a.concat serialize_safe_string(entity[:rentalFeeSink])
      a.concat serialize_long(entity[:rentalFee])
      temp = Nis::Util::Convert.hex2ua(Nis::Util::Convert.utf8_to_hex(entity[:newPart]))
      a.concat serialize_int(temp.size)
      a.concat temp
      if entity[:parent]
        temp = Nis::Util::Convert.hex2ua(Nis::Util::Convert.utf8_to_hex(entity[:parent]))
        a.concat serialize_int(temp.size)
        a.concat temp
      else
        a.concat [255, 255, 255, 255]
      end
      a
    end

    def self.serialize_mosaic_definition_creation(entity)
      a = []
      a.concat serialize_mosaic_definition(entity[:mosaicDefinition])
      a.concat serialize_safe_string(entity[:creationFeeSink])
      a.concat serialize_long(entity[:creationFee])
      a
    end

    def self.serialize_mosaic_supply_change(entity)
      a = []
      mo_id = entity[:mosaicId]
      a_ns = Nis::Util::Convert.hex2ua(Nis::Util::Convert.utf8_to_hex(mo_id[:namespaceId]))
      a_ns_len = serialize_int(a_ns.size)
      a_mo = Nis::Util::Convert.hex2ua(Nis::Util::Convert.utf8_to_hex(mo_id[:name]))
      a_mo_len = serialize_int(a_mo.size)
      a.concat serialize_int((a_ns_len + a_ns + a_mo_len + a_mo).size)
      a.concat a_ns_len
      a.concat a_ns
      a.concat a_mo_len
      a.concat a_mo
      a.concat serialize_int(entity[:supplyType])
      a.concat serialize_long(entity[:delta])
      a
    end

    def self.serialize_common(entity)
      a = []
      a.concat serialize_int(entity[:type])
      a.concat serialize_int(entity[:version])
      a.concat serialize_int(entity[:timeStamp])

      temp = Nis::Util::Convert.hex2ua(entity[:signer])
      a.concat serialize_int(temp.size)
      a.concat temp

      a.concat serialize_long(entity[:fee].to_i)
      a.concat serialize_int(entity[:deadline])
      a
    end

    # Safe String - Each char is 8 bit
    # @param [String] str
    # @return [Array]
    def self.serialize_safe_string(str)
      return [255, 255, 255, 255] if str.nil?
      return [0, 0, 0, 0] if str.empty?
      [str.size, 0, 0, 0] + str.bytes
    end

    # @param [String] str
    # @return [Array]
    def self.serialize_bin_string(str)
      return [255, 255, 255, 255] if str.nil?
      return [0, 0, 0, 0] if str.empty?
      chars = str.is_a?(String) ? str.chars : str
      [chars.size, 0, 0, 0] + chars.map(&:to_i)
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_int(value)
      a = [0, 0, 0, 0]
      bin = sprintf('%032b', value)
      0.upto(bin.size / 8 - 1) do |i|
        a[i] = 0xFF & (value >> 8 * i)
      end
      a
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_long(value)
      a = [0, 0, 0, 0, 0, 0, 0, 0]
      bin = sprintf('%040b', value)
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
      a.concat serialized_mosaic_id + serialized_quantity
    end

    # @param [Array <Nis::Struct::Mosaic>] entities
    # @return [Array]
    def self.serialize_mosaics(entities)
      a = [].fill(0, 0, 4)
      a[0] = entities.size
      a + entities.map do |ent|
        # {
        #   entity: ent,
        #   value: "#{ent.mosaic_id.namespace_id}:#{ent.mosaic_id.name}:#{ent.quantity}"
        # }
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
      a.concat serialize_safe_string(entity[:namespaceId])
      a.concat serialize_safe_string(entity[:name])
      serialize_int(a.size) + a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_property(entity)
      a = []
      a.concat serialize_safe_string(entity[:name])
      a.concat serialize_safe_string(entity[:value])
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
      serialize_int(entities.size) + entities
        .sort_by { |ent| order[ent[:name]] }
        .inject([]) { |memo, ent| memo + serialize_property(ent) }
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_levy(entity)
      return [0, 0, 0, 0] if entity.nil?
      a = []
      a.concat serialize_int(entity[:type])
      a.concat serialize_safe_string(entity[:recipient])
      a.concat serialize_mosaic_id(entity[:mosaicId])
      a.concat serialize_long(entity[:fee])
      serialize_int(a.size) + a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_mosaic_definition(entity)
      a = []
      temp = Nis::Util::Convert.hex2ua(entity[:creator])
      a.concat serialize_int(temp.size)
      a.concat temp
      a.concat serialize_mosaic_id(entity[:id])
      a.concat serialize_bin_string(Nis::Util::Convert.hex2ua(Nis::Util::Convert.utf8_to_hex(entity[:description])))
      a.concat serialize_properties(entity[:properties])
      a.concat serialize_levy(entity[:levy])
      serialize_int(a.size) + a
    end
  end
end
