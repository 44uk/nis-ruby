class Nis
  class Keypair
    attr_reader :private, :public

    # @param [String] Hex Private Key
    # @option options [Strung] :public_key Hex Public Key
    def initialize(private_key, public_key: nil)
      @private = private_key
      @public  = public_key || calc_public_key
    end

    # @param [String] Hex string
    # @return  [String] Signed hex string
    def sign(data)
      bin_data = Nis::Util::Convert.hex2bin(data)
      bin_signed = Nis::Util::Ed25519.signature_hash_unsafe(bin_data, bin_secret, bin_public)
      bin_signed.unpack('H*').first
    end

    private

    def fix_private_key(key)
      "#{'0' * 64}#{key.sub(/^00/i, '')}"[-64, 64]
    end

    def calc_public_key
      bin_public.unpack('H*').first
    end

    def bin_secret
      @bin_secret ||= Nis::Util::Convert.hex2bin_rev(fix_private_key(@private))
    end

    def bin_public
      @bin_public ||= Nis::Util::Ed25519.publickey_hash_unsafe(bin_secret)
    end
  end
end
