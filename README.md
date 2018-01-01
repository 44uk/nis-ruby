# /!\ Information /!\

**Refactored and New gem for nem => [44uk/nem-ruby](https://github.com/44uk/nem-ruby/)**

**Please use [nem-ruby](https://github.com/44uk/nem-ruby/). Discontinue the development of this gem.**

# nis-ruby

[![Gem Version](https://badge.fury.io/rb/nis-ruby.svg)](https://badge.fury.io/rb/nis-ruby)
[![Build Status](https://travis-ci.org/44uk/nis-ruby.svg?branch=master)](https://travis-ci.org/44uk/nis-ruby)
[![Code Climate](https://codeclimate.com/github/44uk/nis-ruby/badges/gpa.svg)](https://codeclimate.com/github/44uk/nis-ruby)
[![Join the chat at https://gitter.im/44uk/nis-ruby](https://badges.gitter.im/44uk/nis-ruby.svg)](https://gitter.im/44uk/nis-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png" width="280" height="280" alt="nem" align="right" />

Ruby client library for the NEM Infrastructure Server(NIS) API.

For further development of nem with ruby, [feel free to send me your feedback!](#feedback-and-contact)

* [NEM \- Distributed Ledger Technology \(Blockchain\)](https://www.nem.io/)
* [NEM NIS API Documentation](https://nemproject.github.io/)
* [NEM Forum](https://forum.nem.io/)
* [NEM Testnet Faucet \- You can get Testnet XEM for development / testing.](http://test-nem-faucet.44uk.net/)

## Installation

```bash
$ gem install nis-ruby
```

Or add this line to your application's Gemfile:

```ruby
gem 'nis-ruby'
```

## Usage

### Examples

More specific example codes are in **[examples/](examples/)** directory.

### Methods

```ruby
require 'rubygems'
require 'nis'
# turn on output request information
Nis.logger.level = Logger::DEBUG

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
# nis = Nis.new(host: '23.228.67.85')
# req = Nis::Request::Announce.new(tx, kp)
# nis.transaction_announce(req)
```

### Requesting

```ruby
require 'rubygems'
require 'nis'
nis = Nis.new

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

## Connection

You can choose nodes from [NEM Node Rewards](https://supernodes.nem.io/).

### Hash

```ruby
# Passing hostname
Nis.new(host: '23.228.67.85')

# Passing url
Nis.new(url: 'http://23.228.67.85:7890')
```

### Environment Variable

```bash
$ export NIS_URL=http://23.228.67.85:7890
```

Environment variable used as default value.

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

## Feedback and Contact

For further development of nem with ruby, feel free to send me your feedback!

* [@44uk_i3 - Twitter](https://twitter.com/44uk_i3)
* [44uk/nis-ruby - gitter](https://gitter.im/44uk/nis-ruby)

## For More Information

* [Documentation for nis-ruby - rubydoc.info](http://www.rubydoc.info/gems/nis-ruby)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nis-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

