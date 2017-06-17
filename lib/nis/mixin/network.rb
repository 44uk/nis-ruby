class Nis
  module Mixin
    module Network
      # @return [Integer]
      def version
        (0x0000000F & @version)
      end

      # @return [Boolean]
      def testnet?
        (0xFFFFFFF0 & @version) == Nis::Util::TESTNET
      end

      # @return [Boolean]
      def mainnet?
        (0xFFFFFFF0 & @version) == Nis::Util::MAINNET
      end
    end
  end
end
