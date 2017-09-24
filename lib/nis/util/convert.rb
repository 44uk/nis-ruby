module Nis::Util
  module Convert
    HEX_ENCODE_ARRAY = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]

    # Reversed convertion of hex to Uint8Array
    # @param [String] hex
    # @return [Array]
    def self.hex2ua_rev(hex)
      hex2ua(hex).reverse
    end

    # Convert hex to Uint8Array
    # @param [String] hex
    # @return [Array]
    def self.hex2ua(hex)
      hex.scan(/../).map(&:hex)
    end

    # Convert an Uint8Array to hex
    # @param [Uint8Array] ua - An Uint8Array
    # @return [string]
    def self.ua2hex(ua)
      ua.map { |el| "#{HEX_ENCODE_ARRAY[el >> 4]}#{HEX_ENCODE_ARRAY[el & 0x0f]}" }.join
    end

    # Convert hex to string
    # @param [String] hex
    # @return [String]
    def self.hex2a(hex)
      hex.scan(/../).map { |el| el.to_i(16).chr }.join
    end

    # Convert UTF-8 to hex
    # @param [string] str
    # @return [string]
    def self.utf8_to_hex(str)
      rstr2utf8(str).each_byte.map { |b| b.to_s(16) }.join
    end

    # // Padding helper for above function
    # let strlpad = function(str, pad, len) {
    #     while (str.length < len) {
    #         str = pad + str;
    #     }
    #     return str;
    # }

    # Convert an Uint8Array to WordArray
    # @param [Uint8Array] ua - An Uint8Array
    # @param [number] uaLength - The Uint8Array length
    # @return [WordArray]
    def self.ua2words(ua, ua_length)
      ua[0, ua_length].each_slice(4).map do |chunk|
        x = chunk[0] * 0x1000000 +
          chunk[1] * 0x10000 +
          chunk[2] * 0x100 +
          chunk[3] * 0x1
        x > 0x7fffffff ? x - 0x100000000 : x
      end
    end

    # Convert a wordArray to Uint8Array
    # @param [Uint8Array] destUa - A destination Uint8Array
    # @param [WordArray] cryptowords - A wordArray
    # @return [Uint8Array]
    def self.words2ua(words)
      words.map do |v|
        temp = []
        v += 0x100000000 if v < 0
        temp[0] = (v >> 24)
        temp[1] = (v >> 16) & 0xff
        temp[2] = (v >> 8) & 0xff
        temp[3] = (v) & 0xff
        temp
      end.flatten
    end

    # Converts a raw javascript string into a string of single byte characters using utf8 encoding.
    # This makes it easier to perform other encoding operations on the string.
    # @param [String] str
    # @return [String]
    def self.rstr2utf8(input)
      input.unpack('U*').map do |c|
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

    # Does the reverse of rstr2utf8.
    def utf82rstr(input)
        # let output = "", i = 0, c = 0, c1 = 0, c2 = 0, c3 = 0;
        # while (i < input.length) {
        #     c = input.charCodeAt(i);
        #     if (c < 128) {
        #         output += String.fromCharCode(c);
        #         i++;
        #     } else if ((c > 191) && (c < 224)) {
        #         c2 = input.charCodeAt(i + 1);
        #         output += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
        #         i += 2;
        #     } else {
        #         c2 = input.charCodeAt(i + 1);
        #         c3 = input.charCodeAt(i + 2);
        #         output += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
        #         i += 3;
        #     }
        # }
        # return output;
    end
  end
end
