module Nis::Endpoint
  module Transaction::PrepareAnnounce
    # @param [Nis::Struct::RequestPrepareAnnounce] request_prepare_announce
    # @return [Nis::Struct::NodeInfo]
    # @see http://bob.nem.ninja/docs/#initiating-a-transaction
    def transaction_prepare_announce(request_prepare_announce:)
      Nis::Struct::NemAnnounceResult.build request!(:post,
        '/transaction/prepare-announce',
        request_prepare_announce
      )
    end
  end
end
