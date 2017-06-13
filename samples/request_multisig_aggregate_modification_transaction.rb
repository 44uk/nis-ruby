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

mcm = Nis::Struct::MultisigCosignatoryModification.new(
  modificationType: 1, # Add
  cosignatoryAccount: B_PUBLIC_KEY
)

# build Transaction Object
tx = Nis::Struct::MultisigAggregateModificationTransaction.new(
  timeStamp: Nis::Util.timestamp,
  type: Nis::Struct::MultisigAggregateModificationTransaction::TYPE,
  deadline: Nis::Util.timestamp + 43_200,
  version:  Nis::Util::TESTNET_VERSION_1,
  signer: A_PUBLIC_KEY,
  modifications: [
    mcm
  ],
  minCosignatories: {
    relativeChange: 1
  }
)

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: tx,
  privateKey: A_PRIVATE_KEY
)

# Create NIS instance
nis = Nis.new

# Send XEM request.
res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
puts res.message
puts hr
