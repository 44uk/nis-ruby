## Connection

```ruby
require 'rubygems'
require 'nis'

# turn on output request information
Nis.logger.level = Logger::DEBUG

# connect to local node
nis = Nis.new

# Passing options
nis = Nis.new(host: '127.0.0.1', port: 7890)

# Passing url
nis = Nis.new(url: 'http://127.0.0.1:7890')

# connect to remote node
nis = Nis.new(host: '23.228.67.85')

# ENV['NIS_URL'] can be used if it set.
# export NIS_URL=http://23.228.67.85:7890
nis = Nis.new
```

You can choose nodes from [NEM Node Rewards](https://supernodes.nem.io/).

## Methods

```ruby
require 'rubygems'
require 'nis'

A_PRIVATE_KEY = '__put_your_private_key__'

nis = Nis.new

nis.heartbeat
# => {code: 1, type: 2, message: "ok"}
# See https://nemproject.github.io/#heart-beat-request

nis.status
# => {code: 6, type: 4, message: "status"}
# See https://nemproject.github.io/#status-request

kp = Nis::Keypair.new(A_PRIVATE_KEY)
tx = Nis::Transaction::Transfer.new(
  RECIPIENT_ADDRESS,
  1, # send 1xem
  'Message',
  network: :testnet # :mainnet (default is :testnet)
)
req = Nis::Request::PrepareAnnounce.new(tx, kp)
# Request to local node.
nis.transaction_prepare_announce(req)
# See https://nemproject.github.io/#initiating-a-transfer-transaction
# => {innerTransactionHash: {}, code: 1, type: 1, message: "SUCCESS", transactionHash: {data: "9da41fd6c6886740ae6a15c869df0470015d78103e5b216971aa09fdbcce9cde"}}

# Request to remote node.
nis = Nis.new(host: '23.228.67.85')
req = Nis::Request::Announce.new(tx, kp)
nis.transaction_announce(req)
```

## API Path

```ruby
require 'rubygems'
require 'nis'
nis = Nis.new(host: '23.228.67.85')

nis.request(:get, '/account/get',
  address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
)
# => [AccountMetaDataPair structure]
# See https://nemproject.github.io/#accountMetaDataPair

nis.request(:post, '/account/unlock',
  privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
)
# => Nothing
# See https://nemproject.github.io/#locking-and-unlocking-accounts
```

## Logging

```ruby
# custom loggin output (default is STDOUT)
Nis.logger = Logger.new('/path/to/nis-ruby.log')
# custom log level
Nis.logger.level = Logger::DEBUG

# or configuration
Nis.configure do |conf|
  conf.logger = Logger.new('/path/to/nis-ruby.log')
  conf.logger.level = Logger::DEBUG
end
```

```
D, [2017-09-26T08:03:54.752718 #78207] DEBUG -- : host:http://127.0.0.1:7890/   method:post     path:/transaction/prepare-announce      params:{:transaction=>{:type=>257, :network=>:testnet, :recipient=>"TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF", :amount=>1000000, :message=>{:payload=>"476f6f64206c75636b21", :type=>1}, :fee=>100000, :timeStamp=>78793049, :deadline=>78796649, :version=>2550136833, :signer=>"be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033"}, :privateKey=>"4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214"}
```

## Examples

More specific example codes are in **[examples/](https://github.com/44uk/nis-ruby/tree/master/examples)** directory.

## XEM for development

You can get Testnet XEM for development / testing from these faucet or thread.

* [NEM Testnet Faucet \- You can get Testnet XEM for development / testing.](http://test-nem-faucet.44uk.net/)
* [NEM TESTNET faucet〜てすとねっと蛇口〜](http://tomotomo9696.xyz/nem/faucet/)
* [NEM testnet Faucet](http://namuyan.dip.jp/nem/testnet/)
* [Paste you address here for beta NEM (Testnet XEM) - Technical Discussion - NEM Forum](https://forum.nem.io/t/paste-you-address-here-for-beta-nem-testnet-xem/829)

## Rubydoc

* [Documentation for nis-ruby - rubydoc.info](http://www.rubydoc.info/gems/nis-ruby)
