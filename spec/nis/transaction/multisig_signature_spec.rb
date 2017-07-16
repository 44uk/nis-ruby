require 'spec_helper'

describe Nis::Transaction::MultisigSignature do
  let(:other_hash) { '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039' }
  let(:other_account) { 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64' }
  let(:signer) { '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933' }
  let(:tx) { described_class.new(other_hash, other_account, signer) }

  subject { tx }

  describe '#type' do
    it { expect(subject.type).to eq 0x1002 }
  end

  describe '#to_hash' do
    it do
      expect(subject.to_hash).to match a_hash_including(
        type: 0x1002,
        otherAccount: 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64',
        otherHash: {
          data: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039'
        },
        # signer: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'
      )
    end
  end
end
