module Nis::Endpoint
  module Namespace::Mosaic
    # @return [Array <Nis::Struct::MosaicDefinitionMetaDataPair>]
    # @see http://bob.nem.ninja/docs/#retrieving-mosaic-definitions
    def namespace_mosaic_definition_page(namespace:, id: nil, page_size: nil)
      request!(:get, '/namespace/mosaic/definition/page',
        namespace: namespace,
        id: id,
        pageSize: page_size
      ) do |res|
        res[:data].map { |mdmdp| Nis::Struct::MosaicDefinitionMetaDataPair.build(mdmdp) }
      end
    end
  end
end
