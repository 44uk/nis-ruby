module Nis::Endpoint
  module Account::Generate
    # @return [Nis::Struct::KeyPairViewModel]
    # @see http://bob.nem.ninja/docs/#generating-new-account-data
    def account_generate
      Nis::Struct::KeyPairViewModel.build request!(:get, '/account/generate')
    end
  end
end
