## heartbeat

```ruby
nis = Nis.new(host: '23.228.67.85')
p nis.heartbeat

# passing API Path
p nis.request :get, 'heartbeat'
```

## status

```ruby
nis = Nis.new(host: '23.228.67.85')
p nis.status

# passing API Path
p nis.request :get, 'status'
```

## shutdown

```ruby
# only accept local node
nis = Nis.new
nis.shutdown
```