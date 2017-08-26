module Nis::Endpoint
  module Account::Status
    # @param [String] address
    # @return [AccountMetaData]
    # @see https://nemproject.github.io/#requesting-the-account-status
    def account_status(address:)
      request!(:get, '/account/status',
        address: address
      ) do |res|
        Nis::Struct::AccountMetaData.build(res)
      end
    end
  end
end
