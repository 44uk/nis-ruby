require 'spec_helper'

describe Nis::Util do
  subject { described_class }

  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  describe '.timestamp' do
    it { expect(subject.timestamp).to eq 0 }
  end

  describe '.deadline' do
    it { expect(subject.deadline).to eq 3_600 }
    it { expect(subject.deadline(43_200)).to eq 43200 }
  end

  describe '.parse_network' do
    it { expect(subject.parse_network(:testnet)).to eq 0x98000000 }
  end

  describe '.parse_version' do
    it { expect(subject.parse_version(:testnet, 1)).to eq 0x98000001 }
  end

  describe '.parse_nemtime' do
    it { expect(subject.parse_nemtime(43_200)).to eq Time.utc(2015, 3, 29, 12, 6, 25, 0) }
  end
end
