module Nis::Endpoint
  module Chain
    module Height
      # @return [Nis::Struct::BlockHeight]
      # @see https://nemproject.github.io/#block-chain-height
      def chain_height
        Nis::Struct::BlockHeight.build request!(:get, '/chain/height')
      end
    end
  end
end
