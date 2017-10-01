require 'nis'
Nis.logger.level = Logger::DEBUG

# output debug log example
# Nis.configure do |conf|
#   conf.logger = Logger.new('./nis-ruby.log')
#   conf.logger.level = Logger::DEBUG
# end

nis = Nis.new

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'
B_PUBLIC_KEY = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'

kp = Nis::Keypair.new(A_PRIVATE_KEY)
tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"

# with encrypted message
message = Nis::Struct::Message.new('Good luck!', type: :encrypted,
  private_key: kp.private,
  public_key: B_PUBLIC_KEY
)
message.encrypt!
tx = Nis::Transaction::Transfer.new(B_ADDRESS, 1, message, {})
puts "Fee: #{tx.fee.to_i}"

req = Nis::Request::PrepareAnnounce.new(tx, kp)
res = nis.transaction_prepare_announce(req)
p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
