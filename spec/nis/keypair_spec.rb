require 'spec_helper'

describe Nis::Keypair do
  let(:private_key) { 'abf4cf55a2b3f742d7543d9cc17f50447b969e6e06f5ea9195d428ab12b7318d' }
  let(:public_key)  { '8a558c728c21c126181e5e654b404a45b4f0137ce88177435a69978cc6bec1f4' }
  let(:keypair) { Nis::Keypair.new(private_key) }

  let(:raw_data) { '8ce03cd60514233b86789729102ea09e867fc6d964dea8c2018ef7d0a2e0e24bf7e348e917116690b9' }
  let(:signed_data) { 'd9cec0cc0e3465fab229f8e1d6db68ab9cc99a18cb0435f70deb6100948576cd5c0aa1feb550bdd8693ef81eb10a556a622db1f9301986827b96716a7134230c' }

  subject { keypair }

  describe '#private' do
    it { expect(subject.private).to eq private_key }
  end

  describe '#public' do
    it { expect(subject.public).to eq public_key }
  end

  describe '#sign' do
    it { expect(subject.sign(raw_data)).to eq signed_data }
  end
end
