module Nis::Endpoint
  module Heartbeat
    # Determines if NIS is up and responsive.
    # @return [Nis::Struct::NemRequestResult] NIS Heartbeat
    # @see https://nemproject.github.io/#heart-beat-request
    def heartbeat
      Nis::Struct::NemRequestResult.build request(:get, '/heartbeat')
    end
  end
end
