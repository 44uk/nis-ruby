## Deserialize transaction

```ruby
# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nis::Keypair.new(A_PRIVATE_KEY)
tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
req = Nis::Request::Announce.new(tx, kp)

p req.to_hash[:data]
p Nis::Util::Deserializer.deserialize_transaction(req.to_hash[:data])
```
