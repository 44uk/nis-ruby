module Nis::Endpoint
  module Account::Harvests
    # @option options [String] address
    # @option options [String] hash
    # @return [Array <Nis::Struct::HarvestInfo>]
    # @see http://bob.nem.ninja/docs/#requesting-harvest-info-data-for-an-account
    def account_harvests(address:, hash: nil)
      request!(:get, '/account/harvests',
        address: address,
        hash: hash
      ) do |res|
        res[:data].map{|hvst| Nis::Struct::HarvestInfo.build(hvst) }
      end
    end
  end
end
