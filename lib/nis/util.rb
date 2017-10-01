module Nis::Util
  MIJIN   = 0x60000000
  TESTNET = 0x98000000 # -1744830464
  MAINNET = 0x68000000 #  1744830464

  VERSION_1 = 0x00000001 # 1
  VERSION_2 = 0x00000002 # 2

  TESTNET_VERSION_1 = TESTNET | VERSION_1 # 0x98000001 = -1744830463
  TESTNET_VERSION_2 = TESTNET | VERSION_2 # 0x98000002 = -1744830462
  MAINNET_VERSION_1 = MAINNET | VERSION_1 # 0x68000001 =  1744830465
  MAINNET_VERSION_2 = MAINNET | VERSION_2 # 0x68000002 =  1744830466

  NEM_EPOCH = Time.utc(2015, 3, 29, 0, 6, 25, 0)

  APOSTILLE_SINK = {
    testnet: 'TC7MCY5AGJQXZQ4BN3BOPNXUVIGDJCOHBPGUM2GE',
    mainnet: 'NCZSJHLTIMESERVBVKOW6US64YDZG2PFGQCSV23J'
  }

  def self.parse_version(network, version)
    parse_network(network) | version
  end

  def self.parse_network(network)
    case network
    when :mijin then MIJIN
    when :mainnet then MAINNET
    when :testnet then TESTNET
      else TESTNET
    end
  end

  def self.parse_nemtime(nemtime)
    NEM_EPOCH + nemtime
  end

  def self.deadline(seconds = 3600)
    timestamp + seconds
  end

  def self.timestamp
    (Time.now.utc - NEM_EPOCH).to_i
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
