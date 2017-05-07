module Nis::Util
  TESTNET = 0x98000000 # -1744830464
  MAINNET = 0x68000000 #  1744830464

  VERSION_1 = 0x00000001 # 1
  VERSION_2 = 0x00000002 # 2

  TESTNET_VERSION_1 = TESTNET | VERSION_1 # 0x98000001 = -1744830463
  TESTNET_VERSION_2 = TESTNET | VERSION_2 # 0x98000002 = -1744830462
  MAINNET_VERSION_1 = MAINNET | VERSION_1 # 0x68000001 =  1744830465
  MAINNET_VERSION_2 = MAINNET | VERSION_2 # 0x68000002 =  1744830466

  NEM_EPOCH = Time.utc(2015, 3, 29, 0, 6, 25, 0)

  #
  # @see http://www.nem.ninja/docs/#namespaces
  NAMESPACE_SINK = {
    testnet: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
    mainnet: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA'
  }

  # @see http://www.nem.ninja/docs/#mosaics
  MOSAIC_SINK = {
    testnet: 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
    mainnet: 'NBMOSAICOD4F54EE5CDMR23CCBGOAM2XSIUX6TRS'
  }

  APOSTILLE_SINK = {
    testnet: 'TC7MCY5AGJQXZQ4BN3BOPNXUVIGDJCOHBPGUM2GE',
    mainnet: 'NCZSJHLTIMESERVBVKOW6US64YDZG2PFGQCSV23J'
  }

  def self.timestamp
    (Time.now - NEM_EPOCH).to_i
  end

  def self.error_handling(hash)
    error_klass = case hash[:error]
                  when 'Not Found' then Nis::NotFoundError
                  when 'Bad Request' then Nis::BadRequestError
                  when 'Internal Server Error' then Nis::InternalServerError
                  else Nis::Error
    end
    error_klass.new(hash[:message])
  end
end

Dir[File.expand_path('../util/*.rb', __FILE__)].each { |f| require f }
