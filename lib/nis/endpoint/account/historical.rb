module Nis::Endpoint
  module Account::Historical
    # @param [String] address
    # @param [Integer] start_height
    # @param [Integer] end_height
    # @param [Integer] increment
    # @return [Array <Nis::Struct::AccountHistoricalDataViewModel>]
    # @see http://bob.nem.ninja/docs/#retrieving-historical-account-data
    def account_historical_get(address:, start_height:, end_height:, increment:)
      request!(:get, '/account/historical/get',
        address: address,
        startHeight: start_height,
        endHeight: end_height,
        increment: increment
      ) do |res|
        res[:data].map{|ahdvm| Nis::Struct::AccountHistoricalDataViewModel(ahdvm) }
      end
    end
  end
end
