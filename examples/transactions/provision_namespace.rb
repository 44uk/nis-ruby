require 'nis'

# owner
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::ProvisionNamespace.new('sushi')
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
