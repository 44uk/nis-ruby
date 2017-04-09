module Nis::Endpoint
  module Account::UnconfirmedTransactions
    # @param [String] address
    # @return [Array <Nis::Struct::UnconfirmedTransactionMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#requesting-transaction-data-for-an-account
    def account_unconfirmed_transactions(address:)
      request!(:get, '/account/unconfirmedTransactions', address: address) do |res|
        res[:data].map { |utmdp| Nis::Struct::UnconfirmedTransactionMetaDataPair.build(utmdp) }
      end
    end
  end
end
