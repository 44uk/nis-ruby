require 'digest/md5'
require 'digest/sha1'
require 'digest/sha2'
require 'digest/sha3'

class Nis::ApostilleAudit
  CHECKSUM = 'fe4e5459'.freeze

  # @param [File] file
  # @param [apostille_hash] Apostille formatted hash
  def initialize(file, apostille_hash)
    @file = file
    @apostille_hash = apostille_hash
    @checksum, @version, @algo, @hash = split_apostille_hash
  end

  def valid?
    raise "Not implemented private apostille" if private?
    raise "Invalid checksum: #{@checksum}" unless @checksum == CHECKSUM
    @hash == calc_hash
  end

  def private?
    @version == 0x80
  end

  def split_apostille_hash
    [ @apostille_hash[0, 8],
      @apostille_hash[8, 1].to_i,
      @apostille_hash[9, 1].to_i,
      @apostille_hash[10, @apostille_hash.size] ]
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
end
