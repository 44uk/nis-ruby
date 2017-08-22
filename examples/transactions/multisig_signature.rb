require 'nis'

# multisig
A_PUBLIC_KEY = '4b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d078'
A_ADDRESS = 'TBAOYZS4FGY5XPQ5OD2VL3SY7GQ5FLH66GRCX5DL'

# cosignatory1
# B_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'
# B_PUBLIC_KEY  = 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'
# B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

# cosignatory2
C_PRIVATE_KEY = '2f6bececfaa81e0ce878be6263df29d11412559132743eebde99f695fbc4e288'
C_ADDRESS = 'TAFPFQOTRYEKMKWWKLLLMYA3I5SCFDGYFACCOFWS'

kp = Nis::Keypair.new(C_PRIVATE_KEY)

nis = Nis.new
txes = nis.account_unconfirmed_transactions(address: C_ADDRESS)

unless txes.size > 0
  puts 'There are no transactions to sign.'
  exit
end

hash = txes.first.meta.data
puts "Unconfirmed Transaction Hash: #{hash}"

tx = Nis::Transaction::MultisigSignature.new(hash, A_ADDRESS, C_PUBLIC_KEY)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
