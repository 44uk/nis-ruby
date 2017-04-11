module Nis::Endpoint
  module Chain
    module Score
      # @return [Nis::Struct::BlockScore]
      # @see http://bob.nem.ninja/docs/#block-chain-score
      def chain_score
        Nis::Struct::BlockScore.build request!(:get, '/chain/score')
      end
    end
  end
end
