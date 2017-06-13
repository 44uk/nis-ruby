class Nis::Struct
  # @attr [Hash] metaData
  # @attr [Hash] endpoint
  # @attr [Hash] identity
  # @see http://bob.nem.ninja/docs/#bootNodeRequest
  class BootNodeRequest
    include Nis::Util::Assignable
    attr_accessor :metaData, :endpoint, :identity

    alias metadata metaData
    alias metadata= metaData=

    def self.build(attrs)
      new(attrs)
    end
  end
end
