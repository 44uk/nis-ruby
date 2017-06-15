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

  describe '#chain_height' do
    it { expect(subject.chain_height)
      .to be_a Nis::Struct::BlockHeight }
  end

  describe '#chain_last_block' do
    it { expect(subject.chain_last_block)
      .to be_a Nis::Struct::Block }
  end

  describe '#chain_score' do
    it { expect(subject.chain_score)
      .to be_a Nis::Struct::BlockScore }
  end

  describe '#block_get' do
    it { expect(subject.block_get(
      block_hash: '58efa578aea719b644e8d7c731852bb26d8505257e03a897c8102e8c894a99d6'
    )).to be_a Nis::Struct::Block }
  end

  describe '#block_at_public' do
    it { expect(subject.block_at_public(
      block_height: 2649
    )).to be_a Nis::Struct::Block }
  end

  describe '#local_account_transfers_incoming' do
    let(:page) do
      Nis::Struct::AccountPrivateKeyTransactionsPage.new(
        value: '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
        hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
        id: 12345
      )
    end
    it { expect(subject.local_account_transfers_incoming(
      page: page
    )).to be_a Array }
  end

  describe '#local_account_transfers_outgoing' do
    let(:page) do
      Nis::Struct::AccountPrivateKeyTransactionsPage.new(
        value: '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
        hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
        id: 12345
      )
    end
    it { expect(subject.local_account_transfers_outgoing(
      page: page
    )).to be_a Array }
  end

  describe '#local_account_transfers_all' do
    let(:page) do
      Nis::Struct::AccountPrivateKeyTransactionsPage.new(
        value: '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
        hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
        id: 12345
      )
    end
    it { expect(subject.local_account_transfers_all(
      page: page
    )).to be_a Array }
  end

  describe '#local_chain_blocks_after' do
    it { expect(subject.local_chain_blocks_after(
      block_height: 2649
    )).to be_a Array }
  end

  describe '#node_info' do
    it { expect(subject.node_info).to be_a Nis::Struct::Node }
  end

  describe '#node_extended_info' do
    it { expect(subject.node_extended_info).to be_a Nis::Struct::NisNodeInfo }
  end

  describe '#node_peer_list_all' do
    it { expect(subject.node_peerlist_all).to be_a Nis::Struct::NodeCollection }
  end

  describe '#node_peer_list_reachable' do
    it { expect(subject.node_peerlist_reachable).to be_a Array }
  end

  describe '#node_peer_list_active' do
    it { expect(subject.node_peerlist_active).to be_a Array }
  end

  describe '#node_active_peers_max_chain_height' do
    it { expect(subject.node_active_peers_max_chain_height).to be_a Nis::Struct::BlockHeight }
  end

  describe '#node_experiences' do
    it { expect(subject.node_experiences).to be_a Nis::Struct::ExtendedNodeExperiencePair }
  end

  describe '#node_boot' do
    let(:bnr) do
      {
        metaData: {
          application: 'NIS'
        },
        endpoint: {
          protocol: 'http',
          port: 7890,
          host: 'localhost'
        },
        identity: {
          'private-key': 'a6cbd01d04edecfaef51df9486c111abb6299c764a00206eb1d01f4587491b3f',
          name: 'Alice'
        }
      }
    end
    it { expect(subject.node_boot(boot_node_request: bnr)).to be nil }
  end

  describe '#namespace_root_page' do
    it { expect(subject.namespace_root_page(
      id: 26754,
      page_size: 35
    )).to be_a Array }
  end

  describe '#namespace' do
    it { expect(subject.namespace(
      namespace: 'makoto.metal.coins'
    )).to be_a Nis::Struct::Namespace }
  end

  describe '#namespace_mosaic_definition_page' do
    it { expect(subject.namespace_mosaic_definition_page(
      namespace: 'makoto.metal.coins'
    )).to be_a Array }
  end

  # describe '#transaction_prepare_announce' do
  #   let(:tx) do
  #     Nis::Struct::TransferTransaction.new(
  #       amount:  1_000_000,
  #       fee:     1_000_000,
  #       recipient: 'TAFPFQOTRYEKMKWWKLLLMYA3I5SCFDGYFACCOFWS',
  #       signer: '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519',
  #       message: {
  #         payload: '',
  #         type: 1
  #       },
  #       type: Nis::Struct::Transaction::TRANSFER,
  #       timeStamp: Nis::Util.timestamp,
  #       deadline:  Nis::Util.timestamp + 43_200,
  #       version:   Nis::Util::TESTNET_VERSION_1
  #     )
  #   end
  #   let(:rpa) do
  #     Nis::Struct::RequestPrepareAnnounce.new(
  #       transaction: tx,
  #       privateKey: '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'
  #     )
  #   end
  #   it { expect(subject.transaction_prepare_announce(request_prepare_announce: rpa))
  #     .to be_a Nis::Struct::NemRequestResult }
  # end

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
