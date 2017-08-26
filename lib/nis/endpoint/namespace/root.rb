module Nis::Endpoint
  module Namespace::Root
    # @return [Array <Nis::Struct::NamespaceMetaDataPair>]
    # @see https://nemproject.github.io/#retrieving-root-namespaces
    def namespace_root_page(id: nil, page_size: nil)
      request!(:get, '/namespace/root/page',
        id: id,
        pageSize: page_size
      ) do |res|
        res[:data].map { |nsmdp| Nis::Struct::NamespaceMetaDataPair.build(nsmdp) }
      end
    end
  end
end
