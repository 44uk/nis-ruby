module Nis::Endpoint
  module Account::Lock
    # @param private_key [String]
    # @return [nil]
    # @see https://nemproject.github.io/#locking-and-unlocking-accounts
    def account_lock(private_key:)
      request!(:post, '/account/lock', value: private_key)
    end
  end
end
