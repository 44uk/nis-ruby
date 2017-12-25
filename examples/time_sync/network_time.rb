require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

p nis.time_sync_network_time
