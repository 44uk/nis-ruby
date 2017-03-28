# nis-ruby

![logomark_and_logotype](https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png)

[![Build Status](https://travis-ci.org/44uk/nis-ruby.svg?branch=master)](https://travis-ci.org/44uk/nis-ruby)

Ruby client library for the NEM Infrastructure Server API

- [NEM \- Distributed Ledger Technology \(Blockchain\)](https://www.nem.io/)
- [NEM NIS API Documentation](http://bob.nem.ninja/docs/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-nis'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem specific_install -l 'git://github.com/44uk/nis-ruby.git'
```

## Usage

```ruby
nis = Nis.new

nis.heartbeat
# => {code: 1, type: 2, message: "ok"}
# See http://bob.nem.ninja/docs/#heart-beat-request

nis.status
# => {code: 6, type: 4, message: "status"}
# See http://bob.nem.ninja/docs/#status-request

nis.request(:get, '/account/get',
  address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
)
# => [AccountMetaDataPair]
# See http://bob.nem.ninja/docs/#accountMetaDataPair

nis.request(:post, '/account/unlock',
  privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
)
# => Nothing
# See http://bob.nem.ninja/docs/#locking-and-unlocking-accounts
```


## Commandline

```bash
$ nis status # => {"code":6,"type":4,"message":"status"}
$ nis heartbeat # => {"code":1,"type":2,"message":"ok"}
```


## TODO

- Do more improvements.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nis-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

