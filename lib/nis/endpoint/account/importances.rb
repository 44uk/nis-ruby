module Nis::Endpoint
  module Account::Importances
    # @return [Array <Nis::Struct::AccountImportanceViewModel>]
    # @see http://bob.nem.ninja/docs/#retrieving-account-importances-for-accounts
    def account_importances
      request!(:get, '/account/importances') do |res|
        res[:data].map{|aivm| Nis::Struct::AccountImportanceViewModel.build(aivm) }
      end
    end
  end
end
