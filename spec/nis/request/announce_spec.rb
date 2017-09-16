require 'spec_helper'

describe Nis::Request::Announce do
  let(:priv_key) { '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f' }
  let(:kp) { Nis::Keypair.new(priv_key) }

  subject { described_class.new(tx, kp) }

  context 'TransferTransaction' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::Transfer.new(
        'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B',
        1,
        'Good luck!'
      )
    end
    let(:data) { '01010000010000983ef0880420000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0da0860100000000004efe8804280000005441574b4a5455503444574b4c444b4b53353334545950364733323443424e4d584b42413458374240420f000000000012000000010000000a000000476f6f64206c75636b21' }
    let(:sign) { 'efd8b4064b624c39729d6a7944ea68b410d13a05684d63e5eff0068595d5bde7721ab5429c950153aef186d15e7eec7bbdd10744cc5c0204df2022d57e213007' }

    it do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'ImportanceTransaction' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::ImportanceTransaction.new(
      )
    end
    let(:data) { '' }
    let(:sign) { '' }

    xit do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'MultisigAggregateModification' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::MultisigAggregateModification.new(
      )
    end
    let(:data) { '' }
    let(:sign) { '' }

    xit do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'MultisigSignature' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::MultisigSignature.new(
      )
    end
    let(:data) { '' }
    let(:sign) { '' }

    xit do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'MultisigTransaction' do
    before { Timecop.freeze Time.utc(2017, 8, 26, 1, 23, 48, 0) }
    after  { Timecop.return }

    let(:priv_key) { '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1' }
    let(:ttx) do
      Nis::Transaction::Transfer.new(
        'TDWWYDGQNBKSAJBSHZX7QWVX7WNVAWWB7HGPWRB2',
        1,
        ''
      )
    end
    let(:tx) do
      Nis::Transaction::Multisig.new(ttx, '4b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d078')
    end
    let(:data) { '0410000001000098a38b8904200000009e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933f049020000000000b3998904740000000101000001000098a38b8904200000004b26a75313b747985470977a085ae6f840a0b84ebd96ddf17f4a31a2b580d07850c3000000000000b39989042800000054445757594447514e424b53414a4253485a58375157565837574e5641575742374847505752423240420f000000000000000000' }
    let(:sign) { '2c3246a405e7c856029f9e66f596f6c5312cc69e1d15de5761c44fdee1fb22b853752a3541cd438a2794284a85859354328553472d1f0fbd710673dd5baa5e0a' }

    it do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'ProvisionNamespace' do
    before { Timecop.freeze Time.utc(2017, 9, 8, 13, 40, 43, 0) }
    after  { Timecop.return }

    let(:priv_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
    let(:tx) do
      Nis::Transaction::ProvisionNamespace.new('foobar')
    end
    let(:data) { '0120000001000098da5b9b0420000000be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033f049020000000000ea699b042800000054414d4553504143455748344d4b464d42435646455244504f4f5034464b374d54444a455950333500e1f5050000000006000000666f6f626172ffffffff' }
    let(:sign) { '1077ea32913e9932ac23416c1f9e9d27dba97d7d8646edaf83cd67c9a5774eb153a9c000f8d9b5f6ffd987c418eef8e1a2bcc20981287c4aa5e2aa2fd52b6f0c' }

    it do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'MosaicDefinitionCreation' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::MosaicDefinitionCreation.new(
      )
    end
    let(:data) { '' }
    let(:sign) { '' }

    xit do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end

  context 'MosaicSupplyChange' do
    before { Timecop.freeze Time.utc(2017, 8, 25, 14, 20, 47, 0) }
    after  { Timecop.return }

    let(:tx) do
      Nis::Transaction::MosaicSupplyChange.new(
      )
    end
    let(:data) { '' }
    let(:sign) { '' }

    xit do
      expect(subject.to_hash).to match a_hash_including(
        data: data,
        signature: sign
      )
    end
  end
end
