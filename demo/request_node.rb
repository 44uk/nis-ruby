require 'nis'
hr = '-' * 64

# create NIS instance
nis = Nis.new

puts nis.node_info
puts hr

puts nis.node_extended_info
puts hr

puts nis.node_experiences
puts hr

puts nis.node_peerlist_all
puts hr

puts nis.node_peerlist_reachable
puts hr

puts nis.node_peerlist_active
puts hr

puts nis.node_active_peers_max_chain_height
puts hr

# bnr = Nis::Struct::BootNodeRequest.new(
# )
# puts nis.node_boot(boot_node_request: bnr)
# puts hr
