require 'spec_helper'

FIXTURES_PATH = File.expand_path('../../fixtures', __FILE__)

describe Nis::Apostille do
  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  let(:private_key) { 'abf4cf55a2b3f742d7543d9cc17f50447b969e6e06f5ea9195d428ab12b7318d' }
  let(:keypair) { Nis::Keypair.new(private_key) }
  let(:file) { File.open(File.join(FIXTURES_PATH, 'nemLogoV2.png')) }
  let(:transaction) { subject.transaction }
  let(:transaction_hash) { '3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f' }
  let(:hashing) { :sha1 }

  subject { described_class.new(keypair, file, hashing) }

  describe '#transaction' do
    it { expect(subject.transaction).to be_a Nis::Transaction::Transfer }
  end

  describe '#apostille_format' do
    it { expect(subject.apostille_format(transaction_hash)).to eq 'nemLogoV2 -- Apostille TX 3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f -- Date 2015-03-29.png' }
  end

  context 'created transaction object' do
    let(:message) do
      Nis::Struct::Message.new('fe4e545902cde315617a435ebfd5fe8875d699e2f2363262f5')
    end
    describe '#message' do
      it { expect(transaction.message).to eq message }
    end

    context 'with private apostille' do
      subject { described_class.new(keypair, file, hashing, type: :private) }
      let(:private_key) { '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1' }

      let(:message) do
        Nis::Struct::Message.new('fe4e5459828f80a7528ac310cbab4d22158ec2efbe06f9407d8ccd5d7742b7522a7a73aa0fec2bd36464fcd0d826817ed02dffd89cc1c1a000b17cedc4e62e67d98e05de0a')
      end
      describe '#message' do
        it { expect(transaction.message).to eq message }
      end
    end
  end
end
