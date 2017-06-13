require 'nis'
hr = '-' * 64

# Account A (Source)
A_ADDRESS = 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT'.freeze
A_PRIVATE_KEY = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'.freeze
A_PUBLIC_KEY  = '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519'.freeze

# Account B (Dist)
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'.freeze

# build Transaction Object
tx = Nis::Struct::TransferTransaction.new(
  amount:  1_000_000,
  # fee:     3_000_000, # see below.
  recipient: B_ADDRESS,
  type: Nis::Struct::TransferTransaction::TYPE,
  signer: A_PUBLIC_KEY,
  message: Nis::Struct::Message.new('Hello'),
  timeStamp: Nis::Util.timestamp,
  deadline:  Nis::Util.timestamp + 43_200,
  version:   Nis::Util::TESTNET_VERSION_1
)

# automatically calculate minimum fee if fee is not set.
puts 'Fee: %d' % tx.fee

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: tx,
  privateKey: A_PRIVATE_KEY
)

# Create NIS instance
nis = Nis.new

# check banalces before sending XEM.
puts 'Account A => balance: %d' %
  (nis.account_get address: A_ADDRESS)[:account][:balance]
puts 'Account B => balance: %d' %
  (nis.account_get address: B_ADDRESS)[:account][:balance]
puts hr

# Send XEM request.
res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
puts res.message

# After several minutes, check Account A and B Balance.
