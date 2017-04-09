module Nis::Endpoint
  module Account::Get
    # @option options [String] address
    # @return [Nis::Struct::AccountMetaDataPair]
    # @see http://bob.nem.ninja/docs/#requesting-the-account-data
    def account_get(address:)
      request!(:get, '/account/get',
        address: address
      ) do |res|
        Nis::Struct::AccountMetaDataPair.build(res)
      end
    end

    # @option options [String] public_key
    # @return [Nis::Struct::AccountMetaDataPair]
    # @see http://bob.nem.ninja/docs/#requesting-the-account-data
    def account_get_from_public_key(public_key:)
      request!(:get, '/account/get/from-public-key',
        publicKey: public_key
      ) do |res|
        Nis::Struct::AccountMetaDataPair.build(res)
      end
    end

    # @option options [String] address
    # @return [Nis::Struct::AccountMetaDataPair]
    # @see http://bob.nem.ninja/docs/#requesting-the-original-account-data-for-a-delegate-account
    def account_get_forwarded(address:)
      request!(:get, '/account/get/forwarded',
        address: address
      ) do |res|
        Nis::Struct::AccountMetaDataPair.build(res)
      end
    end

    # @option options [String] public_key
    # @return [Nis::Struct::AccountMetaDataPair] delegate account
    # @see http://bob.nem.ninja/docs/#requesting-the-original-account-data-for-a-delegate-account
    def account_get_forwarded_from_public_key(public_key:)
      request!(:get, '/account/get/forwarded/from-public-key',
        publicKey: public_key
      ) do |res|
        Nis::Struct::AccountMetaDataPair.build(res)
      end
    end
  end
end
