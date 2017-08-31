require 'nis'
require 'pp'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

# fetch mosaic information
nis = Nis.new(host: '104.128.226.60')
mo_dmdps = nis.namespace_mosaic_definition_page(namespace: 'sushi')
mo_def = mo_dmdps.first.mosaic

# require 'pry'; binding.pry

# mosaic_id = Nis::Struct::MosaicId.new(
#   namespaceId: 'sushi',
#   name: 'anago'
# )

# properties = Nis::Struct::MosaicProperties.new(
#   divisibility: 0,
#   initialSupply: 10_000,
#   supplyMutable: true,
#   transferable: true
# )

# mo_def = Nis::Struct::MosaicDefinition.new(
#   id: mosaic_id,
#   properties: properties,
# )

tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1_000_000, 'Good luck!')
tx.mosaics << Nis::Struct::MosaicAttachment.new(mo_def, 1_000_000)

# pp tx.to_hash

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
pp req.to_hash
# res = nis.transaction_prepare_announce(req)

#
# puts "Message: #{res.message}"
# puts "TransactionHash: #{res.transaction_hash}"
