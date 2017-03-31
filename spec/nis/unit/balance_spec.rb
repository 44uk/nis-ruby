require 'spec_helper'

describe Nis::Unit::Balance do
  let(:value){ 123456789 }
  let(:balance){ described_class.new(value) }
  let(:other){ described_class.new(value) }

  subject { balance }

  describe '#in_nem?' do
    it { expect(subject.in_nem).to eq 123.456789 }
  end

  describe '#==' do
    it { expect(subject == other).to eq true }
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq '123456789' }
  end
end
