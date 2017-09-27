module Nis::Endpoint
  module Local
    module Account
      module Transfers
        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def local_account_transfers_incoming(page:)
          request!(:post, '/local/account/transfers/incoming', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def local_account_transfers_outgoing(page:)
          request!(:post, '/local/account/transfers/outgoing', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        # @param [Nis::Struct::AccountPrivateKeyTransactionsPage] page
        # @return [Array <Nis::Struct::TransactionMetaDataPair>]
        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def local_account_transfers_all(page:)
          request!(:post, '/local/account/transfers/all', page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        def local_account_transfers(dir = :all, page:)
          request!(:post, "/local/account/transfers/#{local_account_transfers_direction(dir)}", page) do |res|
            res[:data].map { |tmdp| Nis::Struct::TransactionMetaDataPair.build(tmdp) }
          end
        end

        def local_account_transfers_direction(dir)
          case dir.to_s
            when /\Ai/ then :incoming
            when /\Ao/ then :outgoing
            else :all
          end
        end
      end
    end
  end
end
