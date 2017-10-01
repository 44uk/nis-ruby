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

    def debug_connections(dir)
      request!(:get, "/debug/connections/#{debug_connections_direction(dir)}") do |res|
        Nis::Struct::AuditCollection.build(
          outstanding: res[:outstanding],
          most_recent: res[:'most-recent']
        )
      end
    end

    def debug_connections_direction(dir)
      case dir.to_s
        when /\Ai/ then :incoming
        when /\Ao/ then :outgoing
        else raise "Undefined direction: #{dir}"
      end
    end
  end
end
