require 'nis'
Nis.logger.level = Logger::DEBUG

A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_historical_get(
  address: A_ADDRESS,
  start_height: 17592,
  end_height: 17592,
  increment: 1
)
