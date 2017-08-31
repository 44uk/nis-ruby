module Nis::Util
  module Deserializer
    # Deserialize a transaction object
    # @param [String] serialized
    # @return [Hash]
    def self.deserialize_transaction(serialized)
      s = Nis::Util::Convert.hex2ua(serialized)
      tx = {}
      tx[:type] = deserialize_int(s[0, 4])
      tx[:version] = deserialize_int(s[4, 4])
      tx[:timeStamp] = deserialize_int(s[8, 4])
      # s[12,4] # length of public key
      tx[:signer] = deserialize_hex(s[16, 32])
      tx[:fee] = deserialize_int(s[48, 8])
      tx[:deadline] = deserialize_int(s[56, 4])
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
      tx
    end

    private

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
