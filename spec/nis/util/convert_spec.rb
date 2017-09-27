require 'spec_helper'

describe Nis::Util::Convert do
  subject { described_class }

  let(:hex) { '10cfe522fe23c015b8ab24ef6a0c32c5de78eb55b2152ed07b6a092121187100' }
  let(:ua)  { [16, 207, 229, 34, 254, 35, 192, 21, 184, 171, 36, 239, 106, 12, 50, 197, 222, 120, 235, 85, 178, 21, 46, 208, 123, 106, 9, 33, 33, 24, 113, 0] }
  let(:ua_rev)  { [0, 113, 24, 33, 33, 9, 106, 123, 208, 46, 21, 178, 85, 235, 120, 222, 197, 50, 12, 106, 239, 36, 171, 184, 21, 192, 35, 254, 34, 229, 207, 16] }

  let(:words) { [7411745, 554265211, -802286158, 1441495262, -986575766, -282809416, 364913662, 585486096] }

  it { expect(subject.hex2ua_rev(hex)).to eq ua_rev }

  it { expect(subject.hex2ua(hex)).to eq ua }
  it { expect(subject.ua2hex(ua)).to eq hex }

  it { expect(subject.ua2words(ua_rev, 32)).to eq words }
  it { expect(subject.words2ua(words)).to eq ua_rev }

  let(:hexstr) { '4e6577206a6f623a20666978204d722e20476c75636b27732068617a792054562c2050445121' }
  let(:str) { "New job: fix Mr. Gluck's hazy TV, PDQ!" }

  it { expect(subject.hex2a(hexstr)).to eq str }

  let(:hex_utf8str) { 'e38184e3828de381afe381abe381bbe381b8e381a8e381a1e3828ae381ace3828be38292e3828fe3818be38288e3819fe3828ce3819de381a4e381ade381aae38289e38280' }
  let(:utf8str) { 'いろはにほへとちりぬるをわかよたれそつねならむ' }

  it { expect(subject.utf8_to_hex(utf8str)).to eq hex_utf8str }
end
