require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

p nis.node_active_peers_max_chain_height
