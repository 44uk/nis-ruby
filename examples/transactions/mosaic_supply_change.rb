require 'nis'

# owner
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'

# TODO: public key calculated from private key in future version.
# it will not need to set public key.
kp = Nis::Keypair.new(A_PRIVATE_KEY, public_key: A_PUBLIC_KEY)

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'sushi',
  name: 'maguro'
)

tx = Nis::Transaction::MosaicSupplyChange.new(mosaic_id, :increase, 1_000)
puts "Fee: #{tx.fee.to_i}"

nis = Nis.new
req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

puts "Message: #{res.message}"
puts "TransactionHash: #{res.transaction_hash}"
