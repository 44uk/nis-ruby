require 'nis'
Nis.logger.level = Logger::DEBUG

A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'
A_PUBLIC_KEY = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'

nis = Nis.new(host: '23.228.67.85')

# /account/get?address={address}
#   -> account_get address: {address}
p nis.account_get(address: A_ADDRESS)
p nis.account_get_from_public_key(public_key: A_PUBLIC_KEY)

# /account/get/from-public-key?public-key={key}
#   -> account_get_public_key public_key: {key}
p nis.account_get_forwarded(address: A_ADDRESS)
p nis.account_get_forwarded_from_public_key(public_key: A_PUBLIC_KEY)
