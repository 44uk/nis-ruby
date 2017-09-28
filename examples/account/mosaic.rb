require 'nis'
Nis.logger.level = Logger::DEBUG

A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new(host: '23.228.67.85')

p nis.account_mosaic_definition_page(:address => A_ADDRESS)
p nis.account_mosaic_owned(address: A_ADDRESS)
