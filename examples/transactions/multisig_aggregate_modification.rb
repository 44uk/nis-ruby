require 'nis'

# multisig
A_PRIVATE_KEY = '9bf8e6fd1a178a3cce39840cda34f80f55fe075c15f48eefad8506f4a70c2b47'

# cosignatory
B_PUBLIC_KEY  = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: B_PUBLIC_KEY
)
min_cosigs = 1

tx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
