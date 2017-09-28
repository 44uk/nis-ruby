require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

p nis.node_info
p nis.node_extended_info
p nis.node_experiences
