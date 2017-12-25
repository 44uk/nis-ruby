require 'nis'
Nis.logger.level = Logger::DEBUG

A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '104.128.226.60')

# transfer
hash = 'a7131c0836da45e72f61ac6e76259d7200a85f0d2cf38f79f223b2c366673b08'
p nis.transaction_get(hash: hash)

# important transfer
hash = '0765dbe0e79c2a57f2f71ae77f915d67b66290b2f72db5b3537bb32a1b09e2bf'
p nis.transaction_get(hash: hash)

# multisig aggregate modification
hash = '9593e7846c01a3a8c00363af9ae7a333cc11e266eb88636957578ae0d9f495a3'
p nis.transaction_get(hash: hash)

# multisig signature
# hash = ''
# p nis.transaction_get(hash: hash)

# transfer (multisig)
hash = '4185cad053f0bc7a2b3b9e5adc493e81a5af2f0a431f3d34ba2a25c937731629'
p nis.transaction_get(hash: hash)

# aggregate (multisig)
hash = 'f7d385a4c8b78d8a6a91c7b778df4ae793394c9c8bfeeca1393bf43770328a06'
p nis.transaction_get(hash: hash)

# provision namespace
hash = '63a3982228b68de56c73896d394cfa3698d7d81e7aec89ea1a77a6d68d103d22'
p nis.transaction_get(hash: hash)

# mosaic definition creation
hash = '0a16d30f57d65c5241cb0894a50fee51efbf6ff25a7a605de10423819234ab5d'
p nis.transaction_get(hash: hash)

# mosaic supply change
hash = '7d2c7f4c2895075a4c1bf2fdceba3781c3a80313e6979c29f1cd83277fe64ded'
p nis.transaction_get(hash: hash)
