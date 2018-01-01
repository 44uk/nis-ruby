## Transfer

### Version1

```ruby
nis = Nis.new

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'
B_PUBLIC_KEY = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'

kp = Nis::Keypair.new(A_PRIVATE_KEY)
tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"

# with encrypted message
message = Nis::Struct::Message.new('Good luck!', type: :encrypted,
  private_key: kp.private,
  public_key: B_PUBLIC_KEY
)
message.encrypt!
tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, message, {})
puts "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)
p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

### Version2(sending mosaic)

```ruby
nis = Nis.new

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

# fetch mosaic definition
mo_dmdps = nis.namespace_mosaic_definition_page(namespace: 'kon')
mo_def = mo_dmdps.first.mosaic

# Or you can use built object if you already know mosaic definition.
# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'kon',
#   name: 'heart'
# )
# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 3,
#   initialSupply: 100_000_000
# )
# mo_def = Nis::Struct::MosaicDefinition.new(
#   id: mosaic_id,
#   properties: properties,
# )

# sending 1xem as mosaic sample
# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'nem',
#   name: 'xem'
# )
# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 6,
#   initialSupply: 8_999_999_999
# )
# mo_def = Nis::Struct::MosaicDefinition.new(
#   id: mosaic_id,
#   properties: properties,
# )
# mosaic_attachment = Nis::Struct::MosaicAttachment.new(mo_def, 1_000_000)

tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
tx.mosaics << Nis::Struct::MosaicAttachment.new(mo_def, 1)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

### Remote node

```ruby
require 'nis'
nis = Nis.new(host: '23.228.67.85')

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::Announce.new(tx, kp)
res = nis.transaction_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"

```

## Importance Transfer

```ruby
# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# remote
B_PUBLIC_KEY = 'cc6c9485d15b992501e57fe3799487e99de272f79c5442de94eeb998b45e0144'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::ImportanceTransfer.new(B_PUBLIC_KEY, :activate)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

## Multisig Signature

```ruby
nis = Nis.new

# multisig
M_PUBLIC_KEY = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'
M_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'

# cosignatory1
# A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
# A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'
# A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

# cosignatory2
B_PRIVATE_KEY = '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1'
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(B_PRIVATE_KEY)

nis = Nis.new
txes = nis.account_unconfirmed_transactions(address: B_ADDRESS)

unless txes.size > 0
  puts 'There are no transactions to sign.'
  exit
end

hash = txes.first.meta.data
p "Unconfirmed Transaction Hash: #{hash}"

tx = Nis::Transaction::MultisigSignature.new(hash, M_ADDRESS, B_PUBLIC_KEY)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

## Namespace

```ruby
nis = Nis.new

# namespace creator
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::ProvisionNamespace.new('sushi')
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

## Mosaic

### Creation

```ruby
# mosaic creator
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'sushi',
  name: 'maguro'
)

properties = Nis::Struct::MosaicProperties.new(
  divisibility: 0,
  initialSupply: 10_000,
  supplyMutable: true,
  transferable: true
)

levy = Nis::Struct::MosaicLevy.new(
  type: 1,
  recipient: A_ADDRESS,
  mosaicId: {
    namespaceId: 'nem',
    name: 'xem'
  },
  fee: 1_000
)

definition = Nis::Struct::MosaicDefinition.new(
  creator: A_PUBLIC_KEY,
  id: mosaic_id,
  description: 'Japanese Soul food SHUSHI.',
  properties: properties,
  levy: levy
)

tx = Nis::Transaction::MosaicDefinitionCreation.new(definition)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

### Supply Change

```ruby
nis = Nis.new

# mosaic owner
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'sushi',
  name: 'maguro'
)

tx = Nis::Transaction::MosaicSupplyChange.new(mosaic_id, :increase, 1_000)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

## Multisig Aggregate Modification

```ruby
nis = Nis.new

# multisig
M_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'

# cosignatory
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_PUBLIC_KEY  = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'

kp = Nis::Keypair.new(M_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: A_PUBLIC_KEY
)
min_cosigs = 1

tx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

### Add cosignatory

```ruby
nis = Nis.new

# multisig
M_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'

# cosignatory1
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# cosignatory2
B_PUBLIC_KEY  = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: B_PUBLIC_KEY
)
min_cosigs = 1

mtx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)
tx = Nis::Transaction::Multisig.new(mtx, M_PUBLIC_KEY)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
```

##

```ruby

```

##

```ruby

```
