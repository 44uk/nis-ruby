require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

# multisig
M_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'

# cosignatory
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

ttx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
tx = Nis::Transaction::Multisig.new(ttx, M_PUBLIC_KEY)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
