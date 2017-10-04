module Nis::Endpoint
  module Account::Transfers
    # @param [String] address
    # @param [String] hash
    # @param [String] id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
    def account_transfers_incoming(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/incoming',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    # @param [String] address
    # @param [String] hash
    # @param [String] id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
    def account_transfers_outgoing(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/outgoing',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    # @param [String] address
    # @param [String] hash
    # @param [String] id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
    def account_transfers_all(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/all',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    # @param [Symbol] dir direction(:in, :out, :all)
    # @param [String] address
    # @param [String] hash
    # @param [String] id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
    def account_transfers(dir = :all, address:, hash: nil, id: nil)
      request!(:get, "/account/transfers/#{account_transfers_direction(dir)}",
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    def account_transfers_direction(dir)
      case dir.to_s
      when /\Ai/ then :incoming
      when /\Ao/ then :outgoing
        else :all
      end
    end
  end
end
