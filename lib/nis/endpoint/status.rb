module Nis::Endpoint
  module Status
    # Determines the status of NIS.
    # @return [Nis::Struct::NemRequestResult] NIS status
    # @see http://bob.nem.ninja/docs/#status-request
    def status
      Nis::Struct::NemRequestResult.build request(:get, '/status')
    end
  end
end
