module Nis::Endpoint
  module Transaction::PrepareAnnounce
    # @param [Nis::Struct::RequestPrepareAnnounce] request
    # @return [Nis::Struct::Node]
    # @see https://nemproject.github.io/#initiating-a-transaction
    def transaction_prepare_announce(request)
      Nis::Struct::NemAnnounceResult.build request!(:post,
        '/transaction/prepare-announce',
        request
      )
    end
  end
end
