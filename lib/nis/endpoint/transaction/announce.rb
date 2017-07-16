module Nis::Endpoint
  module Transaction::Announce
    # @param [Nis::Struct::RequestAnnounce] request_announce
    # @return [Nis::Struct::Node]
    # @see http://bob.nem.ninja/docs/#sending-the-data-to-NIS
    def transaction_announce(request_announce)
      Nis::Struct::NemAnnounceResult.build request!(:post,
        '/transaction/announce',
        request_announce
      )
    end
  end
end
