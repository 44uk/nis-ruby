require 'nis'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

# fetch mosaic information
nis = Nis.new
mo_dmdps = nis.namespace_mosaic_definition_page(namespace: 'sushi')
mo_def = mo_dmdps.first.mosaic

# Or you can use built object if you already know mosaic definition.
# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'sushi',
#   name: 'anago'
# )
# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 0,
#   initialSupply: 10_000
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

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
