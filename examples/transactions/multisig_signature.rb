require 'nis'

# multisig
M_PUBLIC_KEY = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'
M_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'

# cosignatory1
# A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
# A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'
# A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

# cosignatory2
B_PRIVATE_KEY = '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1'
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(B_PRIVATE_KEY)

nis = Nis.new
txes = nis.account_unconfirmed_transactions(address: B_ADDRESS)

unless txes.size > 0
  puts 'There are no transactions to sign.'
  exit
end

hash = txes.first.meta.data
puts "Unconfirmed Transaction Hash: #{hash}"

tx = Nis::Transaction::MultisigSignature.new(hash, M_ADDRESS, B_PUBLIC_KEY)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
