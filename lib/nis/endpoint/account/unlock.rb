module Nis::Endpoint
  module Account::Unlock
    # @param [String] private_key
    # @return [nil]
    # @see https://nemproject.github.io/#locking-and-unlocking-accounts
    def account_unlock(private_key:)
      request!(:post, '/account/unlock', value: private_key)
    end
  end
end
