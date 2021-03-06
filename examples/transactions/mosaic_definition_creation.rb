require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

# mosaic creator
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_PUBLIC_KEY = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'sushi',
  name: 'maguro'
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
  description: 'Japanese Soul food SHUSHI.',
  properties: properties,
  levy: levy
)

tx = Nis::Transaction::MosaicDefinitionCreation.new(definition)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
