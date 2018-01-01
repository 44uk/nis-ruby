## account transfers

```ruby
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

nis = Nis.new

page = Nis::Struct::AccountPrivateKeyTransactionsPage.new(
  value: '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'
)

# mapped methods
p nis.local_account_transfers_incoming(page: page)
p nis.local_account_transfers_outgoing(page: page)
p nis.local_account_transfers_all(page: page)

# another way
p nis.local_account_transfers(:in, page: page)
p nis.local_account_transfers(:out, page: page)
p nis.local_account_transfers(:all, page: page)
```

##chain blocks after

```ruby
nis = Nis.new

p nis.local_chain_blocks_after(block_height: 2_649)
```
