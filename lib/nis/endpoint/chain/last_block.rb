module Nis::Endpoint
  module Chain
    module LastBlock
      # @return [Nis::Struct::Block]
      # @see http://bob.nem.ninja/docs/#last-block-of-the-block-chain-score
      def chain_last_block
        request!(:get, '/chain/last-block') do |res|
          res[:transactions] = res[:transactions].map { |t| Nis::Struct::Transaction.new(t) }
          Nis::Struct::Block.build res
        end
      end
    end
  end
end
