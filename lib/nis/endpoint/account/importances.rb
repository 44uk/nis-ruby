module Nis::Endpoint
  module Account::Importances
    # @return [Array <Nis::Struct::AccountImportanceViewModel>]
    # @see https://nemproject.github.io/#retrieving-account-importances-for-accounts
    def account_importances
      request!(:get, '/account/importances') do |res|
        res[:data].map { |aivm| Nis::Struct::AccountImportanceViewModel.build(aivm) }
      end
    end
  end
end
