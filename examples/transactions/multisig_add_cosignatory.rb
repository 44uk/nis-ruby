require 'nis'

# Account A (multisig)
A_PUBLIC_KEY  = '4b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d078'

# Account B (cosignatory1)
B_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# Account C (cosignatory2)
C_PUBLIC_KEY  = '9fd1e5e886c4006efc715a0e183f2a87f198b8d19c44e7c67925b01aa45a7114'

kp = Nis::Keypair.new(B_PRIVATE_KEY)

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1,
  cosignatoryAccount: C_PUBLIC_KEY
)
min_cosigs = 2
mtx = Nis::Transaction::MultisigAggregateModification.new([mcm], min_cosigs)

tx = Nis::Transaction::Multisig.new(mtx, A_PUBLIC_KEY)

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
