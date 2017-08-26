module Nis::Endpoint
  module Block::At
    # @param [Integer] block_height
    # @return [Nis::Struct::Block]
    # @see https://nemproject.github.io/#getting-a-block-with-a-given-height
    def block_at_public(block_height:)
      Nis::Struct::Block.build request!(:post, '/block/at/public', height: block_height)
    end
  end
end
