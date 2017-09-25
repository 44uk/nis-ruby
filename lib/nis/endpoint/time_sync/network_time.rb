module Nis::Endpoint
  module TimeSync::NetworkTime
    # @return [Nis::Struct::NetworkTime]
    def time_sync_network_time
      request!(:get, '/time-sync/network-time') do |res|
        Nis::Struct::NetworkTime.build res
      end
    end
  end
end
