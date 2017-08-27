require 'nis'
Nis.logger.level = Logger::DEBUG

A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new([
  { host: '23.228.67.85' },
  { host: '127.0.0.1' }
])

p nis.account_get(address: A_ADDRESS)
