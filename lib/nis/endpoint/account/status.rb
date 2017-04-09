module Nis::Endpoint
  module Account::Status
    # @option options [String] :address
    # @return [AccountMetaData]
    # @see http://bob.nem.ninja/docs/#requesting-the-account-status
    def account_status(address:)
      request!(:get, '/account/status',
        address: address
      ) do |res|
        Nis::Struct::AccountMetaData.build(res)
      end
    end
  end
end
