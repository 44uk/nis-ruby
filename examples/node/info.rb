require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

p nis.node_info
p nis.node_extended_info
p nis.node_experiences
