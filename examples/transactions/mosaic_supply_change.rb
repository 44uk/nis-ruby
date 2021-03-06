require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

# mosaic owner
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

mosaic_id = Nis::Struct::MosaicId.new(
  namespaceId: 'sushi',
  name: 'maguro'
)

tx = Nis::Transaction::MosaicSupplyChange.new(mosaic_id, :increase, 1_000)
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
