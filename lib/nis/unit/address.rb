require 'openssl'
require 'base32'
require 'digest/sha3'

module Nis::Unit
  # @attr [String] value
  class Address
    attr_accessor :value

    def initialize(value)
      @value = value
      @first_char = @value[0]
    end

    # @return [Boolean]
    def valid?
      !!(@value =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ234567]{40}/)
    end

    # @return [Boolean]
    def mainnet?
      @first_char == 'N'
    end

    # @return [Boolean]
    def testnet?
      @first_char == 'T'
    end

    # @return [Boolean]
    def mijin?
      @first_char == 'M'
    end

    # @return [String]
    def to_s
      @value
    end

    # @return [String]
    def to_hexadecimal
      @value.each_byte.inject('') { |memo, b| memo << b.to_s(16) }
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end

    def self.from_public_key(public_key, network = :testnet)
      bin_public_key = public_key.scan(/../).map(&:hex).pack('C*')
      public_key_hash = Digest::SHA3.digest(bin_public_key, 256)
      ripe = OpenSSL::Digest::RIPEMD160.digest(public_key_hash)

      if network == :testnet
        version = "\x98".force_encoding('ASCII-8BIT') + ripe
      elsif network == :mijin
        version = "\x60" + ripe
      else
        version = "\x68" + ripe
      end

      checksum = Digest::SHA3.digest(version, 256)[0...4]
      self.new(Base32.encode(version + checksum))
    end
  end
end
