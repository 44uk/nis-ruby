## generate

```ruby
keypair = nis.account_generate

p keypair

# Access properties.
# Names are same API response.
p keypair.address
p keypair.privateKey
p keypair.publicKey

# Ruby style access.
# Also can be access property by snakecase.
p keypair.private_key
p keypair.public_key

# hash like access.
# Also can be access property like hash.
p keypair[:privateKey]
p keypair[:private_key]

# Address object
# Properties wrapped by value object.
p address = keypair.address
p address.testnet?
```

## get

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'
A_PUBLIC_KEY = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'

nis = Nis.new(host: '23.228.67.85')

p nis.account_get(address: A_ADDRESS)
p nis.account_get_from_public_key(public_key: A_PUBLIC_KEY)

p nis.account_get_forwarded(address: A_ADDRESS)
p nis.account_get_forwarded_from_public_key(public_key: A_PUBLIC_KEY)

# /account/get?address={address}
#   -> account_get address: {address}
# Passing parameters by keyword arguments.
account_meta_pair = nis.account_get(address: keypair.address)
account = account_meta_pair[:account]
p account.balance

# /account/get/from-public-key?public-key={key}
#   -> account_get_public_key public_key: {key}
account_meta_pair = nis.account_get_from_public_key(public_key: keypair.public_key)
account = account_meta_pair.account
p account.address
```

## harvests

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_harvests(address: A_ADDRESS)
```

## harvests

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_historical_get(
  address: A_ADDRESS,
  start_height: 17592,
  end_height: 17592,
  increment: 1
)
```

## importances

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_importances
```

## lock/unlock

```ruby
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

nis = Nis.new(host: '23.228.67.85')

nis.account_lock(private_key: A_PRIVATE_KEY)
```

```ruby
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

nis = Nis.new(host: '23.228.67.85')

nis.account_unlock(private_key: A_PRIVATE_KEY)
```

## namespace

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_namespace_page(:address => A_ADDRESS)
```

## mosaic

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_mosaic_definition_page(:address => A_ADDRESS)
p nis.account_mosaic_owned(address: A_ADDRESS)
```

## status

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_status(address: A_ADDRESS)
```

## transfers

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

# mapped methods
p nis.account_transfers_incoming(address: A_ADDRESS)
p nis.account_transfers_outgoing(address: A_ADDRESS)
p nis.account_transfers_all(address: A_ADDRESS)

# another way
p nis.account_transfers(:in,  address: A_ADDRESS)
p nis.account_transfers(:out, address: A_ADDRESS)
p nis.account_transfers(:all, address: A_ADDRESS)
```

## undonfirmed transactions

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_unconfirmed_transactions(address: A_ADDRESS)
```