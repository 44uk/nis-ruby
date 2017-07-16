class Nis
  class Keypair
    attr_reader :private, :public

    def initialize(private_key, public_key: nil)
      @private = private_key
      @public  = public_key
    end

    def fix_private_key(key)
      "#{'0' * 64}#{key.sub(/^00/i, '')}"[-64, 64]
    end

    def calc_pubkey
      # TODO: calculate pubkey from privkey
    end
  end
end
