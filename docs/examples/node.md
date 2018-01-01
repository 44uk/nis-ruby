## Info

```ruby
nis = Nis.new(host: '23.228.67.85')

p nis.node_info
p nis.node_extended_info
p nis.node_experiences
```

## Peerlist

```ruby
nis = Nis.new(host: '23.228.67.85')

# mapped methods
p nis.node_peerlist_all
p nis.node_peerlist_reachable
p nis.node_peerlist_active

# another way
p nis.node_peerlist(:all)
p nis.node_peerlist(:reachable)
p nis.node_peerlist(:active)
```

## Active peers max chain height

```ruby
nis = Nis.new(host: '23.228.67.85')

p nis.node_active_peers_max_chain_height
```

## Boot node request

```ruby
nis = Nis.new

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
  p nis.node_boot(boot_node_request: bnr)
rescue => ex
  p ex
end
```
