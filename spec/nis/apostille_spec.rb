require 'spec_helper'

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

describe Nis::Apostille do
  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  let(:private_key) { 'abf4cf55a2b3f742d7543d9cc17f50447b969e6e06f5ea9195d428ab12b7318d' }
  let(:keypair) { Nis::Keypair.new(private_key) }
  let(:file) { File.open(File.join(FIXTURES_PATH, 'nemLogoV2.png')) }
  let(:transaction) { subject.transaction }
  let(:transaction_hash) { '3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f' }

  subject { described_class.new(keypair, file, :sha1) }

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
    # md5
    # fe4e5459017978dd88f51937fcf376a349e033cc40
    # sha256
    # fe4e545903f1007272252a69dc54e09d5caf6dc2844ae77b27773f61905ae49865ceb89ded
  end
end
