module Nis::Endpoint
  module Status
    # @return [hash] NIS status
    # @see http://bob.nem.ninja/docs/#status-request
    def status
      Nis::Struct::NemRequestResult.build request(:get, '/status')
    end
  end
end
