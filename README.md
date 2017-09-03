# nis-ruby

[![Gem Version](https://badge.fury.io/rb/nis-ruby.svg)](https://badge.fury.io/rb/nis-ruby)
[![Build Status](https://travis-ci.org/44uk/nis-ruby.svg?branch=master)](https://travis-ci.org/44uk/nis-ruby)
[![Code Climate](https://codeclimate.com/github/44uk/nis-ruby/badges/gpa.svg)](https://codeclimate.com/github/44uk/nis-ruby)
[![Join the chat at https://gitter.im/44uk/nis-ruby](https://badges.gitter.im/44uk/nis-ruby.svg)](https://gitter.im/44uk/nis-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png" width="280" height="280" alt="nem" align="right" />

Ruby client library for the NEM Infrastructure Server(NIS) API.

- [NEM \- Distributed Ledger Technology \(Blockchain\)](https://www.nem.io/)
- [NEM NIS API Documentation](https://nemproject.github.io/)
- [NEM Forum](https://forum.nem.io/)

*The gem is under development. Incompatible changes can be made.*

*Do a thorough test on testnet before you use this gem on production.*

- [NEM Testnet Faucet \- You can get Testnet XEM for development / testing.](http://test-nem-faucet.44uk.net/)

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

More specific example codes are in **examples/** directory.

### Methods

```ruby
require 'rubygems'
require 'nis'
nis = Nis.new

nis.heartbeat
# => {code: 1, type: 2, message: "ok"}
# See https://nemproject.github.io/#heart-beat-request

nis.status
# => {code: 6, type: 4, message: "status"}
# See https://nemproject.github.io/#status-request

kp = Nis::Keypair.new(SENDER_PRIV_KEY)
tx = Nis::Transaction::Transfer.new(
  RECIPIENT_ADDRESS,
  10_000_000,
  'Message'
)
req = Nis::Request::PrepareAnnounce.new(tx, kp)
# Request to local node.
nis.transaction_prepare_announce(req)
# See https://nemproject.github.io/#initiating-a-transfer-transaction
# => {innerTransactionHash: {}, code: 1, type: 1, message: "SUCCESS", transactionHash: {data: "9da41fd6c6886740ae6a15c869df0470015d78103e5b216971aa09fdbcce9cde"}}

# Request to remote node.
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

## Commandline

```bash
$ nis status
# => {"code":6,"type":4,"message":"status"}

$ nis heartbeat
# => {"code":1,"type":2,"message":"ok"}

$ nis request get account/get --params=address:TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS
# => [AccountMetaDataPair structure]

$ nis request get account/harvests --params=address:TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS hash:81d52a7df4abba8bb1613bcc42b6b93cf3114524939035d88ae8e864cd2c34c8
# => [Array <HervestInfo structure>]
```

## Connection

You can find nodes here. [NEM Node Rewards](https://supernodes.nem.io/)

### Hash

```ruby
# Passing hostname
Nis.new(host: 'bigalice3.nem.ninja')

# Passing url
Nis.new(url: 'http://bigalice3.nem.ninja:7890')
```

### Environment Variable

```bash
$ export NIS_URL=http://bigalice3.nem.ninja:7890
$ nis heartbeat # => {"code":1,"type":2,"message":"ok"}
```

Environment variable used as default value.

## For More Information

* [Documentation for nis-ruby - rubydoc.info](http://www.rubydoc.info/gems/nis-ruby)

## TODO

* Do more improvements
  * Encryption message
  * Failover connection
  * Be more easy to use

## Contact

Feel free to ask me if you have any questions.

* [@44uk_i3 - Twitter](https://twitter.com/44uk_i3)
* [44uk/nis-ruby - gitter](https://gitter.im/44uk/nis-ruby)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nis-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

