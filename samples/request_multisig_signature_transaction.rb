require 'nis'
hr = '-' * 64

# Account A (change to multisig)
A_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'.freeze
A_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'.freeze
A_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'.freeze

# Account B (cosignatory)
B_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'.freeze
B_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'.freeze
B_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'.freeze

# Account C (cosignatory)
C_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'.freeze
C_PRIVATE_KEY = '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1'.freeze
C_PUBLIC_KEY  = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'.freeze

require 'pry'

nis = Nis.new
txes = nis.account_unconfirmed_transactions(address: C_ADDRESS)

unless txes.size > 0
  puts 'There are no transactions to sign.'
  exit
end

hash = txes.first.meta.data

puts "Unconfirmed Transaction Hash: #{hash}"
puts hr

# build Transaction Object
tx = Nis::Struct::MultisigSignatureTransaction.new(
  timeStamp: Nis::Util.timestamp,
  type: Nis::Struct::MultisigSignatureTransaction::TYPE,
  deadline: Nis::Util.timestamp + 43_200,
  version:  Nis::Util::TESTNET_VERSION_1,
  signer: C_PUBLIC_KEY,
  fee:  6_000_000,
  otherHash: {
    data: hash
  },
  otherAccount: A_ADDRESS
)

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: tx,
  privateKey: C_PRIVATE_KEY
)

# Create NIS instance
nis = Nis.new

# Send XEM request.
res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
puts res.message
