module Nis::Endpoint
  module Block::Get
    # @param [String] block_hash
    # @return [Nis::Struct::Block]
    # @see https://nemproject.github.io/#requesting-parts-of-the-block-chain
    def block_get(block_hash:)
      Nis::Struct::Block.build request!(:get, '/block/get', blockHash: block_hash)
    end
  end
end
