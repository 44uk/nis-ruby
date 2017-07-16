require 'nis'

# create NIS instance
nis = Nis.new

# "/account/generate"
#   -> account_generate
# Each endpoint mapped into method name.
# It returns Nis::Struct object which mapped API response.
keypair = nis.account_generate

# Access properties.
# Names are same API response.
puts keypair.address
puts keypair.privateKey
puts keypair.publicKey

# Ruby style access.
# Also can be access property by snakecase.
puts keypair.private_key
puts keypair.public_key

# hash like access.
# Also can be access property like hash.
puts keypair[:privateKey]
puts keypair[:private_key]

# Address object
# Some property wrapped by value object.
puts address = keypair.address
puts address.testnet?

# /account/get?address={address}
#   -> account_get address: {address}
# Passing parameters by keyword arguments.
account_meta_pair = nis.account_get(address: keypair.address)
account = account_meta_pair[:account]
puts account.balance

# /account/get/from-public-key?public-key={key}
#   -> account_get_public_key public_key: {key}
account_meta_pair = nis.account_get_from_public_key(public_key: keypair.public_key)
account = account_meta_pair.account
puts account.address
