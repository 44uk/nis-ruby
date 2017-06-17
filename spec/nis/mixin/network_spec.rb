require 'spec_helper'

describe Nis::Mixin::Network do
  let(:instance) do
    Class.new do
      include Nis::Mixin::Network
      def initialize(version)
        @version = version
      end
    end.new(Nis::Util::TESTNET_VERSION_1)
  end

  subject { instance }

  describe '#testnet?' do
    it { expect(subject.testnet?).to be true }
  end

  describe '#mainnet?' do
    it { expect(subject.mainnet?).to be false }
  end

  describe '#version' do
    it { expect(subject.version).to be 1 }
  end
end
