require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

# mapped methods
p nis.node_peerlist_all
p nis.node_peerlist_reachable
p nis.node_peerlist_active

# another way
p nis.node_peerlist(:all)
p nis.node_peerlist(:reachable)
p nis.node_peerlist(:active)
