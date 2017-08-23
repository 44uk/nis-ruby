module Nis::Endpoint
  module Transaction::Announce
    # @param [Nis::Struct::RequestAnnounce] request
    # @return [Nis::Struct::Node]
    # @see http://bob.nem.ninja/docs/#sending-the-data-to-NIS
    def transaction_announce(request)
      Nis::Struct::NemAnnounceResult.build request!(:post,
        '/transaction/announce',
        request
      )
    end
  end
end
