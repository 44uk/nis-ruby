require 'spec_helper'

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

describe Nis::ApostilleAudit do
  let(:file) { File.open(File.join(FIXTURES_PATH, 'nemLogoV2 -- Apostille TX 3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f -- Date 2017-10-04.png')) }
  let(:apostille_hash) { 'fe4e545902cde315617a435ebfd5fe8875d699e2f2363262f5' }

  subject { described_class.new(file, apostille_hash) }

  describe '#valid?' do
    it { expect(subject.valid?).to be true }
  end
end
