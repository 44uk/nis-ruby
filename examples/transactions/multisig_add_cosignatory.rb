require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

# multisig
M_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'

# cosignatory1
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# cosignatory2
B_PUBLIC_KEY  = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: B_PUBLIC_KEY
)
min_cosigs = 1

mtx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)
tx = Nis::Transaction::Multisig.new(mtx, M_PUBLIC_KEY)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
