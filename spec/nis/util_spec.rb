require 'spec_helper'

describe Nis::Util do
  subject { described_class }

  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  describe '.timestamp' do
    it { expect(subject.timestamp).to eq 0 }
  end

  describe '.deadline' do
    it { expect(subject.deadline(3600)).to eq 3600 }
  end

  describe '.parse_network' do
    it { expect(subject.parse_network(:testnet)).to eq 0x98000000 }
  end

  describe '.parse_version' do
    it { expect(subject.parse_version(:testnet, 1)).to eq 0x98000001 }
  end
end
