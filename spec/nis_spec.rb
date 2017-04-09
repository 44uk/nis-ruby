require 'spec_helper'
require 'webmock_helper'

describe Nis do
  let(:nis) { Nis.new }

  subject { nis }

  describe '#heartbeat' do
    it { expect(subject.heartbeat)
      .to be_a Nis::Struct::NemRequestResult }
  end

  describe '#status' do
    it { expect(subject.status)
      .to be_a Nis::Struct::NemRequestResult }
  end

  describe '#account_generate' do
    it { expect(subject.account_generate)
      .to be_a Nis::Struct::KeyPairViewModel }
  end

  describe '#account_get' do
    it { expect(subject.account_get(
      address: Nis::Unit::Address.new('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS')
    )).to be_a Nis::Struct::AccountMetaDataPair }
  end

  describe '#account_get_from_public_key' do
    it { expect(subject.account_get_from_public_key(
      public_key: 'f9bd190dd0c364261f5c8a74870cc7f7374e631352293c62ecc437657e5de2cd'
    )).to be_a Nis::Struct::AccountMetaDataPair }
  end

  describe '#account_get_forwarded' do
    it { expect(subject.account_get_forwarded(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be_a Nis::Struct::AccountMetaDataPair }
  end

  describe '#account_get_from_public_key' do
    it { expect(subject.account_get_forwarded_from_public_key(
      public_key: 'f9bd190dd0c364261f5c8a74870cc7f7374e631352293c62ecc437657e5de2cd'
    )).to be_a Nis::Struct::AccountMetaDataPair }
  end

  describe '#account_status' do
    it { expect(subject.account_status(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be_a Nis::Struct::AccountMetaData }
  end

  describe '#account_transfers_incoming' do
    it { expect(subject.account_transfers_incoming(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be_a Array }
  end

  describe '#account_transfers_outgoing' do
    it { expect(subject.account_transfers_outgoing(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be_a Array }
  end

  describe '#account_transfers_all' do
    it { expect(subject.account_transfers_all(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be_a Array }
  end

  describe '#account_unconfirmed_transactions' do
    it { expect(subject.account_unconfirmed_transactions(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
    )).to be {} }
    # )).to be_a Array }
  end

  describe '#account_harvests' do
    it { expect(subject.account_harvests(
      address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS',
      hash: '81d52a7df4abba8bb1613bcc42b6b93cf3114524939035d88ae8e864cd2c34c8'
    )).to be_a Array }
  end

  describe '#account_importances' do
    it { expect(subject.account_importances).to be_a Array }
  end

  describe '#account_namespace_page' do
    it { expect(subject.account_namespace_page(
      address: 'TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH',
      parent: 'makoto.metal'
    )).to be_a Array }
  end

  describe '#account_mosaic_definition_page' do
    it { expect(subject.account_mosaic_definition_page(
      address: 'TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH',
      parent: 'makoto.metal.coins'
    )).to be_a Array }
  end

  describe '#account_mosaic_owned' do
    it { expect(subject.account_mosaic_owned(
      address: 'TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH'
    )).to be_a Array }
  end

  describe '#account_unlock' do
    it { expect(subject.account_unlock(
      private_key: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
    )).to be nil }
  end

  describe '#account_lock' do
    it { expect(subject.account_lock(
      private_key: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
    )).to be nil }
  end

  describe '#account_unlocked_info' do
    it { expect(subject.account_unlocked_info)
      .to eq hash_stub_from_json 'account_unlocked_info' }
  end

  describe '#debug_connections_incoming' do
    it { expect(subject.debug_connections_incoming)
      .to be_a Nis::Struct::AuditCollection }
  end

  describe '#debug_connections_outgoing' do
    it { expect(subject.debug_connections_outgoing)
      .to be_a Nis::Struct::AuditCollection }
  end

  describe '#debug_connections_timers' do
    it { expect(subject.debug_connections_timers)
      .to be_a Array }
  end

  describe '#request' do
    context '/account/get' do
      it { expect(subject.request(:get, 'account/get',
        address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
      )).to eq hash_stub_from_json 'account_get' }
    end

    context '/account/get/from-public-key' do
      it { expect(subject.request(:get, 'account/get/from-public-key',
        publicKey: 'f9bd190dd0c364261f5c8a74870cc7f7374e631352293c62ecc437657e5de2cd'
      )).to eq hash_stub_from_json 'account_get' }
    end

    context '/account/unlock' do
      it { expect(subject.request(:post, '/account/unlock',
        privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
      )).to eq nil }
    end
  end
end
