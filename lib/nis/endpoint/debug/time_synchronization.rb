module Nis::Endpoint
  module Debug::TimeSynchronization
    # @return [TimeSynchronizationResult]
    # @see http://bob.nem.ninja/docs/#monitoring-the-network-time
    def debug_time_synchronization
      request!(:get, '/debug/time-synchronization') do |res|
        res[:data].map { |tsr| Nis::Struct::TimeSynchronizationResult.build(tsr) }
      end
    end
  end
end
