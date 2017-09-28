require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

p nis.time_sync_network_time
