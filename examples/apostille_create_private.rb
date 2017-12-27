require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

FIXTURES_PATH = File.expand_path('../../spec/fixtures', __FILE__)

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

file = File.open("#{FIXTURES_PATH}/nemLogoV2.png")
ap = Nis::Apostille.new(kp, file, :sha1,
  multisig: false,
  type: :private,
  network: :testnet
)
tx = ap.transaction
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::Announce.new(tx, kp)
res = nis.transaction_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
p "ApostilleFormat: #{ap.apostille_format(res.transaction_hash)}"
p "DedicatedPrivateKey: #{ap.dedicated_keypair.private}"

File.write('dedicaded_private_key.txt', ap.dedicated_keypair.private)
FileUtils.cp(file.path, ap.apostille_format(res.transaction_hash))
