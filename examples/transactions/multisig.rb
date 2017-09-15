require 'nis'

# multisig
M_PUBLIC_KEY  = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'

# cosignatory
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

ttx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
tx = Nis::Transaction::Multisig.new(ttx, M_PUBLIC_KEY)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
