module Nis::Endpoint
  module Status
    # Determines the status of NIS.
    # @return [Nis::Struct::NemRequestResult] NIS status
    # @see https://nemproject.github.io/#status-request
    def status
      Nis::Struct::NemRequestResult.build request(:get, '/status')
    end
  end
end
