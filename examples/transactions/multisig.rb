require 'nis'

# multisig
# A_PRIVATE_KEY = '9bf8e6fd1a178a3cce39840cda34f80f55fe075c15f48eefad8506f4a70c2b47'
A_PUBLIC_KEY  = '4b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d078'
# A_ADDRESS = 'TBAOYZS4FGY5XPQ5OD2VL3SY7GQ5FLH66GRCX5DL'

# cosignatory
B_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'
B_PUBLIC_KEY  = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

# TODO: public key calculated from private key in future version.
# it will not need to set public key.
kp = Nis::Keypair.new(B_PRIVATE_KEY, public_key: B_PUBLIC_KEY)

ttx = Nis::Transaction::Transfer.new(B_ADDRESS, 1_000_000, 'Good luck!')
tx = Nis::Transaction::Multisig.new(ttx, A_PUBLIC_KEY)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
