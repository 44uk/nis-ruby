## Create

*Now, only support public Apostille.*

```ruby
nis = Nis.new(host: '23.228.67.85')

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nis::Keypair.new(A_PRIVATE_KEY)

file = File.open('/path/to/file.txt')
ap = Nis::Apostille.new(kp, file, :sha1,
  multisig: false,
  private: false,
  network: :testnet
)
tx = ap.transaction
p "Fee: #{tx.fee.to_i}"

req = Nis::Request::Announce.new(tx, kp)
res = nis.transaction_announce(req)

p "Message: #{res.message}"
p "TransactionHash: #{res.transaction_hash}"
p "ApostilleFormat: #{ap.apostille_format(res.transaction_hash)}"

FileUtils.cp(file.path, ap.apostille_format(res.transaction_hash))
```

## Audit

*Now, only support public Apostille.*

```ruby
nis = Nis.new(host: '23.228.67.85')

FIXTURES_PATH = File.expand_path('../../spec/fixtures', __FILE__)

tx_hash = '3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f'

tx = nis.transaction_get(hash: tx_hash)
apostille_hash = tx.transaction.message[:payload]
file = File.open('path/to/file -- Apostille TX 3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f -- Date 2017-10-04.txt')

apa = Nis::ApostilleAudit.new(file, apostille_hash)
p apa.valid?
```
