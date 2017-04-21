require 'nis'
hr = '-' * 64

# Account A (Source)
A_ADDRESS = 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT'.freeze
A_PRIVATE_KEY = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'.freeze
A_PUBLIC_KEY  = '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519'.freeze

# Account B (Dist)
B_ADDRESS = 'TAFPFQOTRYEKMKWWKLLLMYA3I5SCFDGYFACCOFWS'.freeze

# build Transaction Object
t = Nis::Struct::Transaction.new(
  amount:  1_000_000,
  fee:     1_000_000,
  recipient: B_ADDRESS,
  signer: A_PUBLIC_KEY,
  message: {
    payload: '',
    type: 1
  },
  type: Nis::Struct::Transaction::TRANSFER,
  timeStamp: Nis::Util.timestamp,
  deadline:  Nis::Util.timestamp + 43_200,
  version:   Nis::Struct::Transaction::TESTNET_VERSION_1
)

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: t,
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

# After several minutes, check to see Account B received XEM.
