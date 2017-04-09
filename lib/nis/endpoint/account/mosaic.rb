module Nis::Endpoint
  module Account::Mosaic
    # @option options [String] address
    # @option options [String] parent
    # @option options [String] id
    # @return [Array <Nis::Struct::MosaicDefinition>]
    # @see http://bob.nem.ninja/docs/##retrieving-mosaic-definitions-that-an-account-has-created
    def account_mosaic_definition_page(address:, parent: nil, id: nil)
      request!(:get, '/account/mosaic/definition/page',
        address: address,
        parent: parent,
        id: id,
      ) do |res|
        res[:data].map { |md| Nis::Struct::MosaicDefinition.build(md) }
      end
    end

    # @option options [String] address
    # @return [Array <Nis::Struct::AccountMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#retrieving-mosaics-that-an-account-owns
    def account_mosaic_owned(address:)
      request!(:get, '/account/mosaic/owned', address: address) do |res|
        res[:data].map { |mo| Nis::Struct::Mosaic.build(mo) }
      end
    end
  end
end
