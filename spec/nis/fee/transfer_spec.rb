require 'spec_helper'

describe Nis::Fee::Transfer do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount)  { 1 }
  let(:message) { '' }
  let(:network) { :testnet }
  let(:tx) do
    Nis::Transaction::Transfer.new(
      recipient,
      amount,
      message,
      mosaics: mosaics,
      network: network
    )
  end
  let(:mosaics) { [] }
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context '1xem, no message' do
    it { is_expected.to eq 50_000 }
  end

  context '1xem, with message' do
    let(:message) { 'Good luck!' }
    it { is_expected.to eq 100_000 }
  end

  context '19,999xem, no message' do
    let(:amount)  { 19_999_000_000 }
    it { is_expected.to eq 50_000 }
  end

  context '20,000xem, no message' do
    let(:amount)  { 20_000_000_000 }
    it { is_expected.to eq 100_000 }
  end

  context 'small business mosaic transfer' do
    let(:mo_def) do
      Nis::Struct::MosaicDefinition.new(
        properties: Nis::Struct::MosaicProperties.new(
          divisibility: 0,
          initialSupply: 10_000,
          supplyMutable: false,
          transferable: true
        )
      )
    end

    context '1ns:mos, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 1_000_000) ] }
      it { is_expected.to eq 50_000 }
    end
  end

  context 'nem:xem transfer' do
    let(:mo_def) do
      Nis::Struct::MosaicDefinition.new(
        properties: Nis::Struct::MosaicProperties.new(
          divisibility: 6,
          initialSupply: 8_999_999_999,
          supplyMutable: false,
          transferable: true
        )
      )
    end

    context '1nem:xem, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 1_000_000) ] }
      it { is_expected.to eq 50_000 }
    end

    context '19,999nem:xem, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 19_999_000_000) ] }
      it { is_expected.to eq 50_000 }
    end

    context '20,000nem:xem, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 20_000_000_000) ] }
      it { is_expected.to eq 100_000 }
    end
  end

  context 'ns:mos transfer' do
    let(:mo_def) do
      Nis::Struct::MosaicDefinition.new(
        properties: Nis::Struct::MosaicProperties.new(
          divisibility: 3,
          initialSupply: 100_000_000,
          supplyMutable: false,
          transferable: true
        )
      )
    end

    context '1,222.212ns:mos, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 1_222_212) ] }
      it { is_expected.to eq 100_000 }
    end

    context '1,333.323ns:mos, no message' do
      let(:mosaics) { [ Nis::Struct::MosaicAttachment.new(mo_def, 1_333_323) ] }
      it { is_expected.to eq 150_000 }
    end
  end

  context 'nem:xem and ns:mos transfer' do
    let(:mo_def1) do
      Nis::Struct::MosaicDefinition.new(
        properties: Nis::Struct::MosaicProperties.new(
          divisibility: 6,
          initialSupply: 8_999_999_999,
          supplyMutable: false,
          transferable: true
        )
      )
    end
    let(:mo_def2) do
      Nis::Struct::MosaicDefinition.new(
        properties: Nis::Struct::MosaicProperties.new(
          divisibility: 3,
          initialSupply: 100_000_000,
          supplyMutable: false,
          transferable: true
        )
      )
    end

    context '1ns:mos and 1nem:xem, no message' do
      let(:mosaics) {
        [ Nis::Struct::MosaicAttachment.new(mo_def1, 1_000_000),
          Nis::Struct::MosaicAttachment.new(mo_def2, 1_000) ]
      }
      it { is_expected.to eq 100_000 }
    end

    context '1,222.212ns:mos and 19,999.000001nem:xem, no message' do
      let(:mosaics) {
        [ Nis::Struct::MosaicAttachment.new(mo_def1, 19_999_000_001),
          Nis::Struct::MosaicAttachment.new(mo_def2, 1_222_212) ]
      }
      it { is_expected.to eq 200_000 }
    end
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context '1xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '1xem, with message' do
      let(:message) { 'Good luck!' }
      it { is_expected.to eq 100_000 }
    end

    context '19,999xem, no message' do
      it { is_expected.to eq 50_000 }
    end

    context '20,000xem, no message' do
      let(:amount)  { 20_000_000_000 }
      it { is_expected.to eq 100_000 }
    end
  end
end
