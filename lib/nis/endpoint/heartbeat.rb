module Nis::Endpoint
  module Heartbeat
    # @return [hash] NIS Heartbeat
    # @see http://bob.nem.ninja/docs/#heart-beat-request
    def heartbeat
      Nis::Struct::NemRequestResult.build request(:get, '/heartbeat')
    end
  end
end
