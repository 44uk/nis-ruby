module Nis::Endpoint
  module Debug::Connections
    # @return [Nis::Struct::AuditCollection]
    # @see https://nemproject.github.io/#monitoring-incoming-and-outgoing-calls
    def debug_connections_incoming
      request!(:get, '/debug/connections/incoming') do |res|
        Nis::Struct::AuditCollection.build(
          outstanding: res[:outstanding],
          most_recent: res[:'most-recent']
        )
      end
    end

    # @return [Nis::Struct::AuditCollection]
    # @see https://nemproject.github.io/#monitoring-incoming-and-outgoing-calls
    def debug_connections_outgoing
      request!(:get, '/debug/connections/outgoing') do |res|
        Nis::Struct::AuditCollection.build(
          outstanding: res[:outstanding],
          most_recent: res[:'most-recent']
        )
      end
    end

    # @return [Array <Nis::Struct::NemAsyncTimerVisitor>]
    # @see https://nemproject.github.io/#monitoring-timers
    def debug_connections_timers
      request!(:get, '/debug/timers') do |res|
        res[:data].map { |natv| Nis::Struct::NemAsyncTimerVisitor.build(natv) }
      end
    end
  end
end
