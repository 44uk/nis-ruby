require 'spec_helper'

describe Nis::Util::Serializer do
  subject { described_class }

  let(:private_key) { '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda' }
  let(:mosaic_id) { { namespaceId: 'makoto.metal.silver', name: 'coin' } }
  let(:mosaic) { { mosaicId: mosaic_id, quantity: 123_000 } }
  let(:property) { { name: 'divisibility', value: '3' } }
  let(:properties) do
    [ { name: 'divisibility', value: '3' },
      { name: 'initialSupply', value: '1000' },
      { name: 'supplyMutable', value: 'false' },
      { name: 'transferable', value: 'true' } ]
  end
  let(:levy) do
    { recipient: 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT',
      mosaic_id: mosaic_id,
      fee: 1_000_000 }
  end
  let(:mosaic_definition) do
    { creator: hex_creator,
      id: mosaic_id,
      description: description,
      properties: properties,
      levy: levy }
  end
  let(:hex_creator) { '10cfe522fe23c015b8ab24ef6a0c32c5de78eb55b2152ed07b6a092121187100' }
  let(:description) { 'A healthy drink with lots of vitamins' }

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

  xit { expect(subject.serialize_mosaic_and_quantity(mosaic)).to eq [43, 0, 0, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 120, 224, 1, 0, 0, 0, 0, 0] }

  xit { expect(subject.serialize_mosaics([mosaic])).to eq [1, 0, 0, 0, 43, 0, 0, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 120, 224, 1, 0, 0, 0, 0, 0] }

  it { expect(subject.serialize_property(property)).to eq [21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51] }

  xit { expect(subject.serialize_properties(properties)).to eq [1, 0, 0, 0, 21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51] }

  xit { expect(subject.serialize_levy(levy)).to eq [91, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 64, 66, 15, 0, 0, 0, 0, 0] }
  it { expect(subject.serialize_levy(nil)).to eq [0, 0, 0, 0] }

  xit { expect(subject.serialize_mosaic_definition(mosaic_definition)).to eq [32, 0, 0, 0, 16, 207, 229, 34, 254, 35, 192, 21, 184, 171, 36, 239, 106, 12, 50, 197, 222, 120, 235, 85, 178, 21, 46, 208, 123, 106, 9, 33, 33, 24, 113, 0, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 37, 0, 0, 0, 65, 32, 104, 101, 97, 108, 116, 104, 121, 32, 100, 114, 105, 110, 107, 32, 119, 105, 116, 104, 32, 108, 111, 116, 115, 32, 111, 102, 32, 118, 105, 116, 97, 109, 105, 110, 115, 1, 0, 0, 0, 21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51, 91, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 31, 0, 0, 0, 19, 0, 0, 0, 109, 97, 107, 111, 116, 111, 46, 109, 101, 116, 97, 108, 46, 115, 105, 108, 118, 101, 114, 4, 0, 0, 0, 99, 111, 105, 110, 64, 66, 15, 0, 0, 0, 0, 0] }

  describe '.serialize_transaction' do
    subject { described_class.serialize_transaction(entity) }

    context 'when transfer' do
      let(:entity) do
        {
          type: 257,
          version: -1744830463,
          timeStamp: 9111526,
          signer: 'a1aaca6c17a24252e674d155713cdf55996ad00175be4af02a20c67b59f9fe8a',
          fee: 3_000_000,
          deadline: 9154726,
          recipient: 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT',
          amount: 1_000_000_000,
          message: {
            payload: 'Hello',
            type: 1
          },
          privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
        }
      end
      let(:common)   { [1, 1, 0, 0, 1, 0, 0, 152, 230, 7, 139, 0, 32, 0, 0, 0, 161, 170, 202, 108, 23, 162, 66, 82, 230, 116, 209, 85, 113, 60, 223, 85, 153, 106, 208, 1, 117, 190, 74, 240, 42, 32, 198, 123, 89, 249, 254, 138, 192, 198, 45, 0, 0, 0, 0, 0, 166, 176, 139, 0] }
      let(:specific) { [40, 0, 0, 0, 84, 65, 72, 52, 77, 66, 82, 54, 77, 78, 76, 90, 75, 74, 65, 86, 87, 53, 90, 74, 67, 77, 70, 65, 76, 55, 82, 83, 53, 85, 50, 89, 79, 68, 85, 81, 75, 76, 67, 84, 0, 202, 154, 59, 0, 0, 0, 0, 10, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0] }

      it { expect(subject).to eq common + specific }

      context 'and multisig' do
        let(:entity) do
          {
            type: 4100,
            version: -1744830463,
            timeStamp: 9111526,
            signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
            fee: 150_000,
            deadline: 9154726,
            otherTrans: {
              type: 257,
              version: -1744830463,
              timeStamp: 9111526,
              signer: 'a1aaca6c17a24252e674d155713cdf55996ad00175be4af02a20c67b59f9fe8a',
              fee: 3_000_000,
              deadline: 9154726,
              recipient: 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT',
              amount: 1_000_000_000,
              message: {
                payload: 'Hello',
                type: 1
              }
            }
          }
        end
        let(:multisig_common) { [4, 16, 0, 0, 1, 0, 0, 152, 230, 7, 139, 0, 32, 0, 0, 0, 190, 43, 169, 203, 21, 165, 71, 17, 13, 81, 26, 77, 67, 192, 72, 47, 187, 88, 77, 120, 120, 26, 186, 192, 31, 176, 83, 209, 143, 74, 0, 51, 240, 73, 2, 0, 0, 0, 0, 0, 166, 176, 139, 0] }
        let(:multisig_specific) { [126, 0, 0, 0] }
        let(:other) { common + specific }

        it { expect(subject).to eq multisig_common + multisig_specific + other }
      end
    end

    context 'when importance transfer' do
      let(:entity) do
        {
          type: 2049,
          version: -1744830463,
          timeStamp: 77258058,
          signer: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933',
          fee: 150_000,
          deadline: 77261658,
          remoteAccount: '1a7ca1c5cf693cae4ec1e62b8a8b9c648bcec309fef1b216520cb07bd8167bfa',
          mode: 1
        }
      end
      let(:common)   { [1, 8, 0, 0, 1, 0, 0, 152, 74, 221, 154, 4, 32, 0, 0, 0, 158, 122, 178, 146, 76, 209, 163, 72, 45, 247, 132, 219, 25, 6, 20, 207, 200, 163, 54, 113, 245, 216, 10, 91, 21, 169, 201, 232, 180, 209, 57, 51, 240, 73, 2, 0, 0, 0, 0, 0, 90, 235, 154, 4 ] }
      let(:specific) { [1, 0, 0, 0, 32, 0, 0, 0, 26, 124, 161, 197, 207, 105, 60, 174, 78, 193, 230, 43, 138, 139, 156, 100, 139, 206, 195, 9, 254, 241, 178, 22, 82, 12, 176, 123, 216, 22, 123, 250] }

      it { expect(subject).to eq common + specific }

      context 'and multisig' do
        let(:entity) do
          {
            type: 4100,
            version: -1744830463,
            timeStamp: 77258058,
            signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
            fee: 150_000,
            deadline: 77261658,
            otherTrans: {
              type: 2049,
              version: -1744830463,
              timeStamp: 77258058,
              signer: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933',
              fee: 150_000,
              deadline: 77261658,
              remoteAccount: '1a7ca1c5cf693cae4ec1e62b8a8b9c648bcec309fef1b216520cb07bd8167bfa',
              mode: 1
            }
          }
        end
        let(:multisig_common) { [4, 16, 0, 0, 1, 0, 0, 152, 74, 221, 154, 4, 32, 0, 0, 0, 190, 43, 169, 203, 21, 165, 71, 17, 13, 81, 26, 77, 67, 192, 72, 47, 187, 88, 77, 120, 120, 26, 186, 192, 31, 176, 83, 209, 143, 74, 0, 51, 240, 73, 2, 0, 0, 0, 0, 0, 90, 235, 154, 4] }
        let(:multisig_specific) { [100, 0, 0, 0] }
        let(:other) { common + specific }

        it { expect(subject).to eq multisig_common + multisig_specific + other }
      end
    end

    context 'when multisig aggregate modification' do
      let(:entity) do
        {
          type: 4097,
          version: -1744830462,
          timeStamp: 77582934,
          signer: '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c',
          fee: 500_000,
          deadline: 77586534,
          modifications: [
            {
              modificationType: 2,
              cosignatoryAccount: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'
            }
          ],
          minCosignatories: {
            relativeChange: 1
          }
        }
      end
      let(:common)   { [1, 16, 0, 0, 2, 0, 0, 152, 86, 210, 159, 4, 32, 0, 0, 0, 109, 114, 181, 125, 43, 193, 153, 211, 40, 231, 234, 62, 36, 119, 95, 127, 97, 71, 96, 188, 24, 243, 248, 80, 28, 211, 218, 169, 135, 12, 196, 12, 32, 161, 7, 0, 0, 0, 0, 0, 102, 224, 159, 4] }
      let(:specific) { [1, 0, 0, 0, 40, 0, 0, 0, 2, 0, 0, 0, 32, 0, 0, 0, 158, 122, 178, 146, 76, 209, 163, 72, 45, 247, 132, 219, 25, 6, 20, 207, 200, 163, 54, 113, 245, 216, 10, 91, 21, 169, 201, 232, 180, 209, 57, 51, 4, 0, 0, 0, 1, 0, 0, 0] }

      it { expect(subject).to eq common + specific }

      context 'and multisig' do
        let(:entity) do
          {
            type: 4100,
            version: -1744830463,
            timeStamp: 77582934,
            signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
            fee: 150_000,
            deadline: 77586534,
            otherTrans: {
              type: 4097,
              version: -1744830462,
              timeStamp: 77582934,
              signer: '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c',
              fee: 500_000,
              deadline: 77586534,
              modifications: [
                {
                  modificationType: 2,
                  cosignatoryAccount: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'
                }
              ],
              minCosignatories: {
                relativeChange: 1
              }
            }
          }
        end
        let(:multisig_common) { [4, 16, 0, 0, 1, 0, 0, 152, 86, 210, 159, 4, 32, 0, 0, 0, 190, 43, 169, 203, 21, 165, 71, 17, 13, 81, 26, 77, 67, 192, 72, 47, 187, 88, 77, 120, 120, 26, 186, 192, 31, 176, 83, 209, 143, 74, 0, 51, 240, 73, 2, 0, 0, 0, 0, 0, 102, 224, 159, 4] }
        let(:multisig_specific) { [116, 0, 0, 0] }
        let(:other) { common + specific }

        it { expect(subject).to eq multisig_common + multisig_specific + other }
      end
    end

    context 'when multisig signature' do
      let(:entity) do
        {
          type: 4098,
          version: -1744830463,
          timeStamp: 77906101,
          signer: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933',
          fee: 150_000,
          deadline: 77909701,
          otherHash: {
            data: 'aa1165310ea9272c420fcfeb880cbf8c0fdc68f76db52c6efacc474509fcd3be'
          },
          otherAccount: 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'
        }
      end
      let(:common)   { [2, 16, 0, 0, 1, 0, 0, 152, 181, 192, 164, 4, 32, 0, 0, 0, 158, 122, 178, 146, 76, 209, 163, 72, 45, 247, 132, 219, 25, 6, 20, 207, 200, 163, 54, 113, 245, 216, 10, 91, 21, 169, 201, 232, 180, 209, 57, 51, 240, 73, 2, 0, 0, 0, 0, 0, 197, 206, 164, 4] }
      let(:specific) { [36, 0, 0, 0, 32, 0, 0, 0, 170, 17, 101, 49, 14, 169, 39, 44, 66, 15, 207, 235, 136, 12, 191, 140, 15, 220, 104, 247, 109, 181, 44, 110, 250, 204, 71, 69, 9, 252, 211, 190, 40, 0, 0, 0, 84, 68, 74, 78, 68, 65, 81, 55, 70, 55, 65, 81, 82, 88, 75, 80, 50, 89, 86, 84, 72, 54, 55, 81, 89, 67, 87, 87, 75, 69, 54, 81, 76, 83, 74, 70, 87, 78, 54, 52] }

      it { expect(subject).to eq common + specific }
    end

    context 'when provision namespace' do
      let(:entity) do
        {
          type: 8193,
          version: -1744830463,
          timeStamp: 77290458,
          signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
          fee: 150000,
          deadline: 77294058,
          rentalFeeSink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
          rentalFee: 100000000,
          parent: nil,
          newPart: 'foobar'
        }
      end
      let(:common)   { [1, 32, 0, 0, 1, 0, 0, 152, 218, 91, 155, 4, 32, 0, 0, 0, 190, 43, 169, 203, 21, 165, 71, 17, 13, 81, 26, 77, 67, 192, 72, 47, 187, 88, 77, 120, 120, 26, 186, 192, 31, 176, 83, 209, 143, 74, 0, 51, 240, 73, 2, 0, 0, 0, 0, 0, 234, 105, 155, 4] }
      let(:specific) { [40, 0, 0, 0, 84, 65, 77, 69, 83, 80, 65, 67, 69, 87, 72, 52, 77, 75, 70, 77, 66, 67, 86, 70, 69, 82, 68, 80, 79, 79, 80, 52, 70, 75, 55, 77, 84, 68, 74, 69, 89, 80, 51, 53, 0, 225, 245, 5, 0, 0, 0, 0, 6, 0, 0, 0, 102, 111, 111, 98, 97, 114, 255, 255, 255, 255] }

      it { expect(subject).to eq common + specific }
    end

    context 'when mosaic definition creation' do
      let(:entity) do
        {
          type: 16385,
          version: -1744830463,
          timeStamp: 77614223,
          signer: 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d',
          fee: 150_000,
          deadline: 77617823,
          mosaicDefinition: {
            creator: 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d',
            id: {
              namespaceId: '44uk',
              name: 'qux'
            },
            description: 'description',
            properties: [
              {
                name: 'divisibility',
                value: '3'
              },
              {
                name: 'initialSupply',
                value: '10000'
              },
              {
                name: 'supplyMutable',
                value: 'true'
              },
              {
                name: 'transferable',
                value: 'true'
              }
            ],
            levy: {
              type: 1,
              recipient: 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B',
              mosaicId: {
                namespaceId: 'nem',
                name: 'xem'
              },
              fee: 1_000
            }
          },
          creationFeeSink: 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
          creationFee: 10_000_000
        }
      end
      let(:common)   { [1, 64, 0, 0, 1, 0, 0, 152, 143, 76, 160, 4, 32, 0, 0, 0, 204, 99, 180, 220, 222, 199, 69, 65, 112, 67, 195, 250, 9, 146, 236, 58, 22, 149, 70, 26, 38, 217, 2, 100, 116, 70, 72, 171, 189, 92, 170, 13, 240, 73, 2, 0, 0, 0, 0, 0, 159, 90, 160, 4] }
      let(:specific) { [8, 1, 0, 0, 32, 0, 0, 0, 204, 99, 180, 220, 222, 199, 69, 65, 112, 67, 195, 250, 9, 146, 236, 58, 22, 149, 70, 26, 38, 217, 2, 100, 116, 70, 72, 171, 189, 92, 170, 13, 15, 0, 0, 0, 4, 0, 0, 0, 52, 52, 117, 107, 3, 0, 0, 0, 113, 117, 120, 11, 0, 0, 0, 100, 101, 115, 99, 114, 105, 112, 116, 105, 111, 110, 4, 0, 0, 0, 21, 0, 0, 0, 12, 0, 0, 0, 100, 105, 118, 105, 115, 105, 98, 105, 108, 105, 116, 121, 1, 0, 0, 0, 51, 26, 0, 0, 0, 13, 0, 0, 0, 105, 110, 105, 116, 105, 97, 108, 83, 117, 112, 112, 108, 121, 5, 0, 0, 0, 49, 48, 48, 48, 48, 25, 0, 0, 0, 13, 0, 0, 0, 115, 117, 112, 112, 108, 121, 77, 117, 116, 97, 98, 108, 101, 4, 0, 0, 0, 116, 114, 117, 101, 24, 0, 0, 0, 12, 0, 0, 0, 116, 114, 97, 110, 115, 102, 101, 114, 97, 98, 108, 101, 4, 0, 0, 0, 116, 114, 117, 101, 74, 0, 0, 0, 1, 0, 0, 0, 40, 0, 0, 0, 84, 65, 87, 75, 74, 84, 85, 80, 52, 68, 87, 75, 76, 68, 75, 75, 83, 53, 51, 52, 84, 89, 80, 54, 71, 51, 50, 52, 67, 66, 78, 77, 88, 75, 66, 65, 52, 88, 55, 66, 14, 0, 0, 0, 3, 0, 0, 0, 110, 101, 109, 3, 0, 0, 0, 120, 101, 109, 232, 3, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 84, 66, 77, 79, 83, 65, 73, 67, 79, 68, 52, 70, 53, 52, 69, 69, 53, 67, 68, 77, 82, 50, 51, 67, 67, 66, 71, 79, 65, 77, 50, 88, 83, 74, 66, 82, 53, 79, 76, 67, 128, 150, 152, 0, 0, 0, 0, 0] }

      it { expect(subject).to eq common + specific }
      # puts Nis::Util::Convert.ua2hex(common + specific)
      # {
      #   "data": "01400000010000986ec0a10420000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0df0490200000000007ecea1040801000020000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d0f000000040000003434756b030000007175780b0000006465736372697074696f6e04000000150000000c00000064697669736962696c69747901000000331a0000000d000000696e697469616c537570706c79050000003130303030190000000d000000737570706c794d757461626c650400000074727565180000000c0000007472616e7366657261626c6504000000747275654a00000001000000280000005441574b4a5455503444574b4c444b4b53353334545950364733323443424e4d584b4241345837420e000000030000006e656d0300000078656de8030000000000002800000054424d4f534149434f443446353445453543444d523233434342474f414d3258534a4252354f4c438096980000000000",
      #   "signature": "82b2d3da3b460a0762c2d522cea3b28e3d6185d9c9c74d1229d1f5ad8325cca52e9ca49d5e5f1e9cc5ade5f875f672e7af8e3ef5b3458e8756c3fbbcd9f3ee0c"
      # }
    end

    context 'when mosaic supply change' do
      let(:entity) do
        {
          type: 16386,
          version: -1744830463,
          timeStamp: 77266167,
          signer: 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d',
          fee: 150_000,
          deadline: 77269767,
          mosaicId: {
            namespaceId: '44uk',
            name: 'gift'
          },
          supplyType: 1,
          delta: 10
        }
      end
      let(:common)   { [2, 64, 0, 0, 1, 0, 0, 152, 247, 252, 154, 4, 32, 0, 0, 0, 204, 99, 180, 220, 222, 199, 69, 65, 112, 67, 195, 250, 9, 146, 236, 58, 22, 149, 70, 26, 38, 217, 2, 100, 116, 70, 72, 171, 189, 92, 170, 13, 240, 73, 2, 0, 0, 0, 0, 0, 7, 11, 155, 4] }
      let(:specific) { [16, 0, 0, 0, 4, 0, 0, 0, 52, 52, 117, 107, 4, 0, 0, 0, 103, 105, 102, 116, 1, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0] }

      it { expect(subject).to eq common + specific }
    end
  end
end
