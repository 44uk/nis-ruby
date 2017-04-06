module Nis::Endpoint
  module Account::Transfers
    # @option options [String] :address
    # @option options [String] :hash
    # @option options [String] :id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#requesting-transaction-data-for-an-account
    def account_transfers_incoming(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/incoming',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map{|tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    # @option options [String] :address
    # @option options [String] :hash
    # @option options [String] :id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#requesting-transaction-data-for-an-account
    def account_transfers_outgoing(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/outgoing',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map{|tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end

    # @option options [String] :address
    # @option options [String] :hash
    # @option options [String] :id
    # @return [Array <Nis::Struct::TransactionMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#requesting-transaction-data-for-an-account
    def account_transfers_all(address:, hash: nil, id: nil)
      request!(:get, '/account/transfers/all',
        address: address,
        hash: hash,
        id: id
      ) do |res|
        res[:data].map{|tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
      end
    end
  end
end
