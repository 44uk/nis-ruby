require 'nis'

# multisig
M_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'

# cosignatory
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_PUBLIC_KEY  = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'

kp = Nis::Keypair.new(M_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: A_PUBLIC_KEY
)
min_cosigs = 1

tx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
