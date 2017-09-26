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

    # Convert an Array to hex
    # @param [Array] ua - An Uint8Array
    # @return [string]
    def self.ua2hex(ua)
      ua.inject('') { |memo, el| memo << "#{HEX_ENCODE_ARRAY[el >> 4]}#{HEX_ENCODE_ARRAY[el & 0x0f]}" }
    end

    # Convert hex to string
    # @param [String] hex
    # @return [String]
    def self.hex2a(hex)
      hex.scan(/../).inject('') { |memo, el| memo << el.hex.chr }
    end

    # @param [Array] bin
    # @return [String]
    def self.bin2hex(bin)
      bin.map { |v| '%02x' % v }.join
    end

    # Convert UTF-8 to hex
    # @param [string] str
    # @return [string]
    def self.utf8_to_hex(str)
      rstr2utf8(str).bytes.inject('') { |memo, b| memo << b.to_s(16) }
    end

    # Convert an Uint8Array to WordArray
    # @param [Array] ua - An Uint8Array
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
    # @param [Array] destUa - A destination Uint8Array
    # @param [Array] cryptowords - A wordArray
    # @return [Array]
    def self.words2ua(words)
      words.inject([]) do |memo, v|
        temp = []
        v += 0x100000000 if v < 0
        temp[0] = (v >> 24)
        temp[1] = (v >> 16) & 0xff
        temp[2] = (v >> 8) & 0xff
        temp[3] = (v) & 0xff
        memo + temp
      end
    end

    # Converts a raw javascript string into a string of single byte characters using utf8 encoding.
    # This makes it easier to perform other encoding operations on the string.
    # @param [String] str
    # @return [String]
    def self.rstr2utf8(str)
      str.unpack('U*').inject('') do |memo, c|
        memo << case
                when c < 128
                  c.chr
                when 128 < c && c < 2048
                  (c >> 6 | 192).chr + (c & 63 | 128).chr
          else
                  (c >> 12 | 224).chr + (c >> 6 & 63 | 128).chr + (c & 63 | 128).chr
        end
      end
    end

    # Does the reverse of rstr2utf8.
    def utf82rstr(input)
      raise 'Not implemented.'
    end
  end
end
