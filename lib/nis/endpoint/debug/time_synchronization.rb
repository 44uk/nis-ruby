module Nis::Endpoint
  module Debug::TimeSynchronization
    # @return [TimeSynchronizationResult]
    # @see https://nemproject.github.io/#monitoring-the-network-time
    def debug_time_synchronization
      request!(:get, '/debug/time-synchronization') do |res|
        res[:data].map { |tsr| Nis::Struct::TimeSynchronizationResult.build(tsr) }
      end
    end
  end
end
