require 'nis'
hr = '-' * 64

# Account A
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'.freeze
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'.freeze
A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'.freeze

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'kon',
  name: 'teas'
)

properties = Nis::Struct::MosaicProperties.new(
  divisibility: 0,
  initialSupply: 10_000,
  supplyMutable: true,
  transferable: true
)

levy = Nis::Struct::MosaicLevy.new(
  type: 1,
  recipient: A_ADDRESS,
  mosaicId: {
    namespaceId: 'nem',
    name: 'xem'
  },
  fee: 1_000
)

definition = Nis::Struct::MosaicDefinition.new(
  creator: A_PUBLIC_KEY,
  id: mosaic_id,
  description: 'Ho-kago Tea Time',
  properties: properties,
  levy: levy
)

# build Transaction Object
tx = Nis::Struct::MosaicDefinitionCreationTransaction.new(
  timeStamp: Nis::Util.timestamp,
  type: Nis::Struct::MosaicDefinitionCreationTransaction::TYPE,
  deadline: Nis::Util.timestamp + 43_200,
  version: Nis::Util::TESTNET_VERSION_1,
  signer: A_PUBLIC_KEY,
  creationFee: 500_000_000,
  creationFeeSink: Nis::Util::MOSAIC_SINK[:testnet],
  mosaicDefinition: definition
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
