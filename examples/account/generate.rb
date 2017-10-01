require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

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
