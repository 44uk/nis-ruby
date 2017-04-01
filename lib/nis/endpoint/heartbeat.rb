module Nis::Endpoint
  module Heartbeat
    # Determines if NIS is up and responsive.
    # @return [Nis::Struct::NemRequestResult] NIS Heartbeat
    # @see http://bob.nem.ninja/docs/#heart-beat-request
    def heartbeat
      Nis::Struct::NemRequestResult.build request(:get, '/heartbeat')
    end
  end
end
