module Nis::Endpoint
  module Mosaic::Supply
    # @return <Nis::Struct::MosaicSupply
    # @see https://nemproject.github.io/#
    def mosaic_supply(mosaic_id:)
      request!(:get, '/mosaic/supply',
        mosaicId: mosaic_id,
      ) do |res|
        Nis::Struct::MosaicSupply.build(res)
      end
    end
  end
end
