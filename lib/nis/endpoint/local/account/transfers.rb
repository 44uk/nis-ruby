module Nis::Endpoint
  module Local
    module Account
      module Transfers
        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see http://bob.nem.ninja/docs/#transaction-data-with-decoded-messages
        def local_account_transfers_incoming(page:)
          request!(:post, '/local/account/transfers/incoming', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see http://bob.nem.ninja/docs/#transaction-data-with-decoded-messages
        def local_account_transfers_outgoing(page:)
          request!(:post, '/local/account/transfers/outgoing', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see http://bob.nem.ninja/docs/#transaction-data-with-decoded-messages
        def local_account_transfers_all(page:)
          request!(:post, '/local/account/transfers/all', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end
      end
    end
  end
end
