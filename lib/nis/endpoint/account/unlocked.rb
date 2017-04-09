module Nis::Endpoint
  module Account::Unlocked
    # @return [Hash <Symbol: num-unlocked>, <Symbol: max-unlocked>]
    # @see http://bob.nem.ninja/docs/#retrieving-the-unlock-info
    def account_unlocked_info
      request!(:post, '/account/unlocked/info')
    end
  end
end
