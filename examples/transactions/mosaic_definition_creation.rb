require 'nis'

# owner
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
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
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
