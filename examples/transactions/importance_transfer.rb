require 'nis'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# remote
B_PUBLIC_KEY = 'cc6c9485d15b992501e57fe3799487e99de272f79c5442de94eeb998b45e0144'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

tx = Nis::Transaction::ImportanceTransfer.new(B_PUBLIC_KEY, :activate)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
