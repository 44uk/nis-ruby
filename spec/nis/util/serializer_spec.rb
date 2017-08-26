require 'spec_helper'

describe Nis::Util::Serializer do
  subject { described_class }
  let(:private_key) { '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda' }
  let(:transaction) do
    {
      timeStamp: 9111526,
      amount: 1_000_000_000,
      fee: 3_000_000,
      recipient: 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT',
      type: 257,
      deadline: 9154726,
      message: {
        payload: 'Hello',
        type: 1
      },
      version: -1744830463,
      signer: 'a1aaca6c17a24252e674d155713cdf55996ad00175be4af02a20c67b59f9fe8a',
      privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
    }
  end
  let(:mosaic_id) do
    Struct.new(:namespace_id, :name).new('makoto.metal.silver', 'coin')
  end
  let(:mosaic) do
    Struct.new(:mosaic_id, :quantity).new(mosaic_id, 123_000)
  end
  let(:property) { { name: 'divisibility', value: '3' } }
  let(:properties) do
    [ { name: 'divisibility', value: '3' },
      # { name: 'initialSupply', value: '1000' },
      # { name: 'supplyMutable', value: 'false' },
      # { name: 'transferable', value: 'true' }
    ]
  end
  let(:levy) do
    { recipient: 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT',
      mosaic_id: mosaic_id,
      fee: 1_000_000 }
  end
  let(:mosaic_definition) do
    {
      creator: hex_creator,
      id: mosaic_id,
      description: description,
      properties: [
        property
      ],
      levy: levy
    }
  end
  let(:description) { 'A healthy drink with lots of vitamins' }
  let(:hex_description) { '41206865616c746879206472696e6b2077697468206c6f7473206f6620766974616d696e73' }

  let(:description_ja) { 'あいうえお' }
  let(:hex_description_ja) { 'e38182e38184e38186e38188e3818a' }

  let(:hex_creator) { '10cfe522fe23c015b8ab24ef6a0c32c5de78eb55b2152ed07b6a092121187100' }
  let(:ua_creator)  { [16, 207, 229, 34, 254, 35, 192, 21, 184, 171, 36, 239, 106, 12, 50, 197, 222, 120, 235, 85, 178, 21, 46, 208, 123, 106, 9, 33, 33, 24, 113, 0] }
  let(:ua_creator_reversed)  { [0, 113, 24, 33, 33, 9, 106, 123, 208, 46, 21, 178, 85, 235, 120, 222, 197, 50, 12, 106, 239, 36, 171, 184, 21, 192, 35, 254, 34, 229, 207, 16] }

  it { expect(subject.serialize_transaction(transaction)).to eq [1, 1, 0, 0, 1, 0, 0, 152, 230, 7, 139, 0, 32, 0, 0, 0, 161, 170, 202, 108, 23, 162, 66, 82, 230, 116, 209, 85, 113, 60, 223, 85, 153, 106, 208, 1, 117, 190, 74, 240, 42, 32, 198, 123, 89, 249, 254, 138, 192, 198, 45, 0, 0, 0, 0, 0, 166, 176, 139, 0, 40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 0, 202, 154, 59, 0, 0, 0, 0, 10, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0] }

  it { expect(subject.serialize_safe_string('Hello')).to eq [5, 0, 0, 0, 72, 101, 108, 108, 111] }
  it { expect(subject.serialize_safe_string(nil)).to eq [255, 255, 255, 255] }
  it { expect(subject.serialize_safe_string('')).to  eq [0, 0, 0, 0] }

  # it { expect(subject.serialize_ua_string('9876543210')).to eq [10, 0, 0, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] }
  # it { expect(subject.serialize_ua_string(nil)).to eq [255, 255, 255, 255] }
  # it { expect(subject.serialize_ua_string('')).to  eq [0, 0, 0, 0] }

  it { expect(subject.serialize_int(0x0101)).to eq [1,  1, 0, 0] }
  it { expect(subject.serialize_int(0x1001)).to eq [1, 16, 0, 0] }
  it { expect(subject.serialize_int(0x2001)).to eq [1, 32, 0, 0] }
  it { expect(subject.serialize_int(0x4001)).to eq [1, 64, 0, 0] }
  it { expect(subject.serialize_int(0x98000001)).to eq [1,  0, 0, 152] }

  it { expect(subject.serialize_long(3_000_000)).to eq [192, 198, 45, 0, 0, 0, 0, 0] }
  it { expect(subject.serialize_long(12_000_000)).to eq [0, 27, 183, 0, 0, 0, 0, 0] }
  it { expect(subject.serialize_long(1_234_000_000)).to eq [128, 88, 141, 73, 0, 0, 0, 0] }
  it { expect(subject.serialize_long(50_000_000_000)).to eq [0, 116, 59, 164, 11, 0, 0, 0] }
  it { expect(subject.serialize_long(100_000_000_000)).to eq [0, 232, 118, 72, 23, 0, 0, 0] }

  it { expect(subject.serialize_mosaic_id(mosaic_id)).to eq [31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110] }

  it { expect(subject.serialize_mosaic_and_quantity(mosaic)).to eq [43, 0, 0, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 120, 224, 1, 0, 0, 0, 0, 0] }

  it { expect(subject.serialize_mosaics([mosaic])).to eq [1, 0, 0, 0, 43, 0, 0, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 120, 224, 1, 0, 0, 0, 0, 0] }

  it { expect(subject.serialize_property(property)).to eq [21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51] }

  it { expect(subject.serialize_properties(properties)).to eq [1, 0, 0, 0, 21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51] }

  it { expect(subject.serialize_levy(levy)).to eq [91, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 64, 66, 15, 0, 0, 0, 0, 0] }
  it { expect(subject.serialize_levy(nil)).to eq [0, 0, 0, 0] }

  it { expect(subject.serialize_mosaic_definition(mosaic_definition)).to eq [32, 0, 0, 0, 16, 207, 229, 34, 254, 35, 192, 21, 184, 171, 36, 239, 106, 12, 50, 197, 222, 120, 235, 85, 178, 21, 46, 208, 123, 106, 9, 33, 33, 24, 113, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 37, 0, 0, 0, 65, 32, 104, 101, 97, 108, 116, 104, 121, 32, 100, 114, 105, 110, 107, 32, 119, 105, 116, 104, 32, 108, 111, 116, 115, 32, 111, 102, 32, 118, 105, 116, 97, 109, 105, 110, 115, 1, 0, 0, 0, 21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51, 91, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 64, 66, 15, 0, 0, 0, 0, 0] }

  it { expect(subject.hex2ua(hex_creator)).to eq ua_creator }
  # it { expect(subject.ua2hex(ua_creator)).to eq hex_creator }
  it { expect(subject.hex2ua_reversed(hex_creator)).to eq ua_creator_reversed }

  it { expect(subject.utf8_to_hex(description)).to eq hex_description }
  it { expect(subject.utf8_to_hex(description_ja)).to eq hex_description_ja }
end
