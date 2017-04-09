module Nis::Endpoint
  module Account::Namespace
    # @option options [String] :address
    # @option options [String] :parent
    # @option options [String] :id
    # @option options [Integer] :page_size
    # @return [Array <Nis::Struct::Namespace>]
    # @see http://bob.nem.ninja/docs/#retrieving-namespaces-that-an-account-owns
    def account_namespace_page(address:, parent: nil, id: nil, page_size: nil)
      request!(:get, '/account/namespace/page',
        address: address,
        parent: parent,
        id: id,
        pageSize: page_size
      ) do |res|
        res[:data].map{|ns| Nis::Struct::Namespace.build(ns) }
      end
    end
  end
end
