require 'nis'
hr = '-' * 64

nis = Nis.new

node_info = nis.node_info
puts node_info.to_hash
puts hr

ext_node_info = nis.node_extended_info
puts ext_node_info.to_hash
puts hr

node_exp = nis.node_experiences
puts node_exp.first.to_hash
puts hr

peer_all = nis.node_peerlist_all
puts peer_all.to_hash
puts hr

reachables = nis.node_peerlist_reachable
puts reachables.first.to_hash
puts hr

actives = nis.node_peerlist_active
puts actives.first.to_hash
puts hr

puts nis.node_active_peers_max_chain_height
puts hr

bnr = Nis::Struct::BootNodeRequest.new(
  metaData: {
    application: 'NIS'
  },
  endpoint: {
    protocol: 'http',
    port: 7890,
    host: 'localhost'
  },
  identity: {
    'private-key': 'a6cbd01d04edecfaef51df9486c111abb6299c764a00206eb1d01f4587491b3f',
    name: 'Alice'
  }
)

begin
  puts nis.node_boot(boot_node_request: bnr)
rescue => ex
  puts ex
end
puts hr
