module Nis::Endpoint
  module Account::Lock
    # @param private_key [String]
    # @return [nil]
    # @see https://nemproject.github.io/#locking-and-unlocking-accounts
    def account_lock(private_key:)
      request!(:post, '/account/lock',
        privateKey: private_key
      )
      nil
    end
  end
end
