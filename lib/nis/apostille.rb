require 'digest/md5'
require 'digest/sha1'
require 'digest/sha2'
require 'digest/sha3'

class Nis::Apostille
  CHECKSUM = 'fe4e5459'.freeze

  # @param [Nis::Keypair] keypair
  # @param [string] file - The file
  # @param [symbol] hashing - An hashing type (md5, sha1, sha256, sha3-256, sha3-512)
  # @param [boolean] multisig - true if transaction is multisig, false otherwise
  # @param [boolean] private - true if apostille is private / transferable / updateable, false if public
  def initialize(keypair, file, hashing = :sha256, multisig: false, private: false, network: :testnet)
    @keypair = keypair
    @file = file
    @hashing = hashing
    @multisig = multisig
    @private = private
    @network = network
  end

  def private?
    @private
  end

  def multisig?
    @multisig
  end

  def transaction
    if private?
      raise 'Not implemented private apostille.'
    else
      dedicated_address = apostille[:sink]
      apostille_hash = calc_hash
    end

    Nis::Transaction::Transfer.new(dedicated_address, 0, apostille_hash)
  end

  def apostille_format(transaction_hash)
    ext = File.extname(@file.path)
    name = File.basename(@file.path, ext)
    date = Date.today.strftime('%Y-%m-%d')
    '%s -- Apostille TX %s -- Date %s%s' % [
      name,
      transaction_hash,
      date,
      ext
    ]
  end

  private

  def calc_hash
    checksum = "#{CHECKSUM}#{hex_type}"
    hashed = case @hashing
             when /\Amd5\z/      then Digest::MD5.file(@file)
             when /\Asha1\z/     then Digest::SHA1.file(@file)
             when /\Asha256\z/   then Digest::SHA256.file(@file)
             when /\Asha3-256\z/ then Digest::SHA3.file(@file, 256)
      else Digest::SHA3.file(@file, 512)
    end
    checksum << hashed.hexdigest
  end

  def algo
    case @hashing
    when /\Amd5\z/      then 0x01
    when /\Asha1\z/     then 0x02
    when /\Asha256\z/   then 0x03
    when /\Asha3-256\z/ then 0x08
    when /\Asha3-512\z/ then 0x09
      else raise "Undefined hashing: #{@hashing}"
    end
  end

  def version
    private? ? 0x80 : 0x00
  end

  def hex_type
    '%02x' % (algo | version)
  end

  def apostille
    if @network == :testnet
      if private?
        raise 'Not implemented private apostille.'
      else
        { private_key: nil,
          sink: 'TC7MCY5AGJQXZQ4BN3BOPNXUVIGDJCOHBPGUM2GE' }
      end
    else
      if private?
        raise 'Not implemented private apostille.'
      else
        { private_key: nil,
          sink: 'NCZSJHLTIMESERVBVKOW6US64YDZG2PFGQCSV23J' }
      end
    end
  end
end
