require 'nis'
Nis.logger.level = Logger::DEBUG

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
