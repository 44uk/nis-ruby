require 'spec_helper'

describe Nis::Util::Deserializer do
  subject { described_class.deserialize_transaction(data) }

  describe '.deserialize_transaction' do
    context 'when transfer' do
      let(:data) { '01010000010000983ef0880420000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0da0860100000000004efe8804280000005441574b4a5455503444574b4c444b4b53353334545950364733323443424e4d584b42413458374200e1f5050000000012000000010000000a000000476f6f64206c75636b21' }
      let(:tx) do
        {
          type: 257,
          fee: 100_000,
          recipient: 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B',
          amount: 100_000_000,
          message: { type: 1, payload: 'Good luck!' },
          timeStamp: 76083262,
          deadline: 76086862,
          # version: -1744830463,
          signer: 'cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d'
        }
      end

      it { expect(subject).to match a_hash_including(tx) }

      context 'and multisig' do
        let(:data) { '' }
        let(:tx) do
        end

        xit { expect(subject).to match a_hash_including(tx) }
      end
    end

    context 'when importance transfer' do
      let(:data) { '01080000010000984add9a04200000009e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933f0490200000000005aeb9a0401000000200000001a7ca1c5cf693cae4ec1e62b8a8b9c648bcec309fef1b216520cb07bd8167bfa' }
      let(:tx) do
        {
          type: 2049,
          # version: -1744830463,
          timeStamp: 77258058,
          signer: '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933',
          fee: 150_000,
          deadline: 77261658,
          remoteAccount: '1a7ca1c5cf693cae4ec1e62b8a8b9c648bcec309fef1b216520cb07bd8167bfa',
          mode: 1
        }
      end

      it { expect(subject).to match a_hash_including(tx) }

      context 'and multisig' do
        let(:data) { '' }
        let(:tx) do
        end

        xit { expect(subject).to match a_hash_including(tx) }
      end
    end

    context 'when multisig aggregate modification' do
      let(:data) { '041000000100009856d29f0420000000be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033f04902000000000066e09f0474000000011000000200009856d29f04200000006d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c20a107000000000066e09f04010000002800000002000000200000009e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d139330400000001000000' }
      let(:tx) do
      end

      xit { expect(subject).to match a_hash_including(tx) }

      context 'and multisig' do
        let(:data) { '' }
        let(:tx) do
        end

        xit { expect(subject).to match a_hash_including(tx) }
      end
    end

    context 'when multisig signature' do
      let(:data) { '0210000001000098b5c0a404200000009e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933f049020000000000c5cea4042400000020000000aa1165310ea9272c420fcfeb880cbf8c0fdc68f76db52c6efacc474509fcd3be2800000054444a4e444151374637415152584b503259565448363751594357574b4536514c534a46574e3634' }
      let(:tx) do
        {
          type: 4098,
          # version: -1744830463,
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

      it { expect(subject).to match a_hash_including(tx) }
    end

    context 'when provision namespace' do
      let(:data) { '0120000001000098da5b9b0420000000be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033f049020000000000ea699b042800000054414d4553504143455748344d4b464d42435646455244504f4f5034464b374d54444a455950333500e1f5050000000006000000666f6f626172ffffffff' }
      let(:tx) do
        {
          type: 8193,
          # version: -1744830463,
          timeStamp: 77290458,
          signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
          fee: 150000,
          deadline: 77294058,
          rentalFeeSink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35',
          rentalFee: 100000000,
          # parent: nil,
          newPart: 'foobar'
        }
      end

      it { expect(subject).to match a_hash_including(tx) }
    end

    context 'when mosaic definition creation' do
      let(:data) { '01400000010000986ec0a10420000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0df0490200000000007ecea1040801000020000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0d0f000000040000003434756b030000007175780b0000006465736372697074696f6e04000000150000000c00000064697669736962696c69747901000000331a0000000d000000696e697469616c537570706c79050000003130303030190000000d000000737570706c794d757461626c650400000074727565180000000c0000007472616e7366657261626c6504000000747275654a00000001000000280000005441574b4a5455503444574b4c444b4b53353334545950364733323443424e4d584b4241345837420e000000030000006e656d0300000078656de8030000000000002800000054424d4f534149434f443446353445453543444d523233434342474f414d3258534a4252354f4c438096980000000000' }
      let(:tx) do
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

      xit { expect(subject).to match a_hash_including(tx) }
    end

    context 'when mosaic supply change' do
      let(:data) { '0240000001000098f7fc9a0420000000cc63b4dcdec745417043c3fa0992ec3a1695461a26d90264744648abbd5caa0df049020000000000070b9b0410000000040000003434756b0400000067696674010000000a00000000000000' }
      let(:tx) do
        {
          type: 16386,
          # version: -1744830463,
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

      it { expect(subject).to match a_hash_including(tx) }
    end
  end
end
