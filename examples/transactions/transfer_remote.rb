require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

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
