require 'nis'
hr = '-' * 64

# Account A (multisig)
A_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'.freeze
A_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'.freeze
A_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'.freeze

# Account B (cosignatory)
B_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'.freeze
B_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'.freeze
B_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'.freeze

# build Transaction Object
tx = Nis::Transaction::Transfer.new(
  amount: 1_000_000,
  recipient: B_ADDRESS,
  message: Nis::Struct::Message.new('Hello'),
  signer: A_PUBLIC_KEY,
  timeStamp: Nis::Util.timestamp,
  deadline: Nis::Util.timestamp + 43_200,
  version: Nis::Util::TESTNET_VERSION_1
)

mtx = Nis::Transaction::Multisig.new(
  otherTrans: tx,
  signer: B_PUBLIC_KEY,
  timeStamp: Nis::Util.timestamp,
  deadline: Nis::Util.timestamp + 43_200,
  version: Nis::Util::TESTNET_VERSION_1
)

# automatically calculate minimum fee if fee is not set.
puts 'Fee: %d' % tx.fee

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: mtx,
  privateKey: B_PRIVATE_KEY
)

# Create NIS instance
nis = Nis.new

# check banalces before sending XEM.
puts 'Account A => balance: %d' %
  (nis.account_get address: A_ADDRESS)[:account][:balance]
puts 'Account B => balance: %d' %
  (nis.account_get address: B_ADDRESS)[:account][:balance]
puts hr

# Send XEM request.
res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
puts res.message
