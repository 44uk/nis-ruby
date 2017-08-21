require 'spec_helper'

describe Nis::Util::Ed25519 do
  subject { described_class }
  let(:private_key) { '11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff' }
  let(:secret_key)  { private_key.scan(/../).map(&:hex).reverse.pack('C*') }
  let(:public_key)  { '7f037853c87e0d73e9005727f76d26ccfddd9d321f61034c6f9b399bc87760e5' }

  describe 'publickey_hash_unsafe' do
    it { expect(subject.publickey_hash_unsafe(secret_key).unpack('H*').first).to eq public_key }
  end
end
