module Nis::Endpoint
  module Chain
    module Height
      # @return [Nis::Struct::BlockHeight]
      # @see http://bob.nem.ninja/docs/#block-chain-height
      def chain_height
        Nis::Struct::BlockHeight.build request!(:get, '/chain/height')
      end
    end
  end
end
