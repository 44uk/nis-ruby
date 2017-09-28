## connections

```ruby
nis = Nis.new(host: '23.228.67.85')

# mapped methods
p nis.debug_connections_incoming
p nis.debug_connections_outgoing
p nis.debug_connections_timers

# another way
p nis.debug_connections(:in)
p nis.debug_connections(:out)
```

## time synchronization

```ruby
nis = Nis.new(host: '23.228.67.85')

p nis.debug_time_synchronization
```
