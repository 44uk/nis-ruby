module Nis::Endpoint
  module Account::Unlocked
    # @return [Hash <Symbol: num-unlocked>, <Symbol: max-unlocked>]
    # @see https://nemproject.github.io/#retrieving-the-unlock-info
    def account_unlocked_info
      request!(:post, '/account/unlocked/info')
    end
  end
end
