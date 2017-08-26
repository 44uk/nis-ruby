module Nis::Endpoint
  module Account::Generate
    # @return [Nis::Struct::KeyPairViewModel]
    # @see https://nemproject.github.io/#generating-new-account-data
    def account_generate
      Nis::Struct::KeyPairViewModel.build request!(:get, '/account/generate')
    end
  end
end
