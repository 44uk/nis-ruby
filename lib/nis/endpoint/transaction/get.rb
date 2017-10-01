module Nis::Endpoint
  module Transaction::Get
    # @param [String] hash
    # @return [Nis::Struct::TransactionMetaDataPair]
    def transaction_get(hash:)
      Nis::Struct::TransactionMetaDataPair.build request!(:get,
        '/transaction/get',
        hash: hash
      )
    end
  end
end
