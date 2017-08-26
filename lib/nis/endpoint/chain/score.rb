module Nis::Endpoint
  module Chain
    module Score
      # @return [Nis::Struct::BlockScore]
      # @see https://nemproject.github.io/#block-chain-score
      def chain_score
        Nis::Struct::BlockScore.build request!(:get, '/chain/score')
      end
    end
  end
end
