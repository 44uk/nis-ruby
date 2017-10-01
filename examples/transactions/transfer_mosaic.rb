require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

# fetch mosaic definition
mo_dmdps = nis.namespace_mosaic_definition_page(namespace: 'kon')
mo_def = mo_dmdps.first.mosaic

# Or you can use built object if you already know mosaic definition.
# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'kon',
#   name: 'heart'
# )
# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 3,
#   initialSupply: 100_000_000
# )
# mo_def = Nis::Struct::MosaicDefinition.new(
#   id: mosaic_id,
#   properties: properties,
# )

# sending 1xem as mosaic sample
# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'nem',
#   name: 'xem'
# )
# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 6,
#   initialSupply: 8_999_999_999
# )
# mo_def = Nis::Struct::MosaicDefinition.new(
#   id: mosaic_id,
#   properties: properties,
# )
# mosaic_attachment = Nis::Struct::MosaicAttachment.new(mo_def, 1_000_000)

tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
tx.mosaics << Nis::Struct::MosaicAttachment.new(mo_def, 1)

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
