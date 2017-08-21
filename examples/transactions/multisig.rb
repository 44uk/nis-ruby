require 'nis'

# multisig
A_PUBLIC_KEY  = '4b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d078'

# cosignatory
B_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nis::Keypair.new(B_PRIVATE_KEY)

ttx = Nis::Transaction::Transfer.new(B_ADDRESS, 1_000_000, 'Good luck!')
tx = Nis::Transaction::Multisig.new(ttx, A_PUBLIC_KEY)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
