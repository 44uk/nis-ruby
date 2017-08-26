require 'nis'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1_000_000, 'Good luck!')
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new(host: '104.128.226.60')
req = Nis::Request::Announce.new(tx, kp)
res = nis.transaction_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
