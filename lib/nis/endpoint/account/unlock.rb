module Nis::Endpoint
  module Account::Unlock
    # @param [String] private_key
    # @return [nil]
    # @see http://bob.nem.ninja/docs/#locking-and-unlocking-accounts
    def account_unlock(private_key:)
      request!(:post, '/account/lock',
        privateKey: private_key
      )
    end
  end
end
