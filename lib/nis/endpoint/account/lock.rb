module Nis::Endpoint
  module Account::Lock
    # @option options [String] private_key
    # @return [nil]
    # @see http://bob.nem.ninja/docs/#locking-and-unlocking-accounts
    def account_lock(private_key:)
      request!(:post, '/account/lock',
        privateKey: private_key
      )
      nil
    end
  end
end
