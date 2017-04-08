module Nis::Endpoint
  module Account::UnconfirmedTransactions
    # @option options [String] :address
    # @return [Array <Nis::Struct::UnconfirmedTransactionMetaDataPair>
    # @see http://bob.nem.ninja/docs/#requesting-the-account-status
    def account_unconfirmed_transactions(address:)
      request!(:get, '/account/unconfirmedTransactions', address: address) do |res|
        res[:data].map{|utmdp| Nis::Struct::UnconfirmedTransactionMetaDataPair.build(utmdp) }
      end
    end
  end
end
