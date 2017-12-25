require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

# mapped methods
p nis.debug_connections_incoming
p nis.debug_connections_outgoing
p nis.debug_connections_timers

# another way
p nis.debug_connections(:in)
p nis.debug_connections(:out)
