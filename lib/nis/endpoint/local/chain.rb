module Nis::Endpoint
  module Local
    module Chain
      # @param [String] block_height
      # @return [Array <Nis::Struct::Block>]
      # @see http://bob.nem.ninja/docs/#getting-part-of-a-chain
      def local_chain_blocks_after(block_height:)
        request!(:post, '/local/chain/blocks-after',
          height: block_height
        ) do |res|
          res[:data].map { |ebvm| Nis::Struct::ExplorerBlockViewModel.build(ebvm) }
        end
      end
    end
  end
end
