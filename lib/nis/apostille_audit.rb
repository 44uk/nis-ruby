require 'digest/md5'
require 'digest/sha1'
require 'digest/sha2'
require 'digest/sha3'

class Nis::ApostilleAudit
  CHECKSUM = 'fe4e5459'.freeze

  # @param [File] file
  # @param [Nis::Struct::TransferTransaction] Apostille transaction
  def initialize(file, apostille_tx)
    @file = file
    @apostille_tx = apostille_hash
    @checksum, @version, @algo, @hash = split_apostille_hash
  end

  def valid?
    raise "Invalid checksum: #{@checksum}" unless @checksum == CHECKSUM
    if private?
      verify_signature
    else
      @hash == calc_hash
    end
  end

  def private?
    @version == 0x80
  end

  def split_apostille_hash
    message = if apostille_tx.type == 4100
      apostille_tx.other_trans.message
    else
      apostille_tx.message
    end
    [ message[0, 8],
      message[8, 1].to_i,
      message[9, 1].to_i,
      message[10, message.size] ]
  end

  private

  def calc_hash
    hashed = case @algo
             when 0x01 then Digest::MD5.file(@file)
             when 0x02 then Digest::SHA1.file(@file)
             when 0x03 then Digest::SHA256.file(@file)
             when 0x08 then Digest::SHA3.file(@file, 256)
             when 0x09 then Digest::SHA3.file(@file, 512)
      else raise "Undefined alog #{@algo}"
    end
    hashed.hexdigest
  end

  def verify_signature
    # TODO:
    raise 'Not implemented auditing private apostille'
  end

  # let verifySignature = function(publicKey, data, signature) {
  #   // Create an hasher object
  #   let hasher = new hashobj();
  #   // Convert public key to Uint8Array
  #   let _pk = convert.hex2ua(publicKey);
  #   // Convert signature to Uint8Array
  #   let _signature = convert.hex2ua(signature);
  #
  #   const c = nacl;
  #   const p = [c.gf(), c.gf(), c.gf(), c.gf()];
  #   const q = [c.gf(), c.gf(), c.gf(), c.gf()];
  #
  #   if (c.unpackneg(q, _pk)) return false;
  #
  #   const h = new Uint8Array(64);
  #   hasher.reset();
  #   hasher.update(_signature.subarray(0, 64/2));
  #   hasher.update(_pk);
  #   hasher.update(data);
  #   hasher.finalize(h);
  #
  #   c.reduce(h);
  #   c.scalarmult(p, q, h);
  #
  #   const t = new Uint8Array(64);
  #   c.scalarbase(q, _signature.subarray(64/2));
  #   c.add(p, q);
  #   c.pack(t, p);
  #
  #   return 0 === nacl.lowlevel.crypto_verify_32(_signature, 0, t, 0);
  # }
end
