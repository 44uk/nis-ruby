require 'nis'

nis = Nis.new

page = Nis::Struct::AccountPrivateKeyTransactionsPage.new(
  value: '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'
)

incoming = nis.local_account_transfers_incoming(page: page)
puts incoming.last.to_hash

outgoing = nis.local_account_transfers_outgoing(page: page)
puts outgoing.last.to_hash

all = nis.local_account_transfers_all(page: page)
puts all.last.to_hash

blocks = nis.local_chain_blocks_after(block_height: 2649)
puts blocks.last
