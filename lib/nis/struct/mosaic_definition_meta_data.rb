class Nis::Struct
  # @attr [Integer] id
  # @see https://nemproject.github.io/#mosaicDefinitionMetaData
  class MosaicDefinitionMetaData
    include Nis::Util::Assignable
    attr_accessor :id

    def self.build(attrs)
      new(attrs)
    end
  end
end
