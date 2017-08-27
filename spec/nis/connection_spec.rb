require 'spec_helper'

describe Nis::Connection do
  let(:connection) { Nis::Connection.new }

  subject { connection }

  describe "\#{attributes}" do
    it { expect(subject.url).to eq 'http://127.0.0.1:7890' }
    it { expect(subject.scheme).to eq 'http' }
    it { expect(subject.host).to eq '127.0.0.1' }
    it { expect(subject.port).to eq 7890 }
    it { expect(subject.timeout).to eq 5 }
    it { expect(subject.priority).to eq 0 }
  end

  context 'when ENV["NIS_URL"] set' do
    before do
      ENV['NIS_URL'] = 'http://nis.example.com:6789'
    end

    after do
      ENV['NIS_URL'] = nil
    end

    describe "\#{attributes}" do
      it { expect(subject.url).to eq 'http://nis.example.com:6789' }
      it { expect(subject.host).to eq 'nis.example.com' }
      it { expect(subject.port).to eq 6789 }
    end
  end

  context 'when passed option values' do
    describe "\#{attributes}" do
      let(:connection) { described_class.new(host: 'localhost', port: 7890) }
      it { expect(subject.url).to eq 'http://localhost:7890' }
      it { expect(subject.host).to eq 'localhost' }
      it { expect(subject.port).to eq 7890 }
    end
  end
end
