class Nis::Struct
  # @attr [Integer] currentTime
  # @attr [String] application
  # @attr [Integer] startTime
  # @attr [String] version
  # @attr [String] signer
  # @see http://bob.nem.ninja/docs/#applicationMetaData
  class ApplicationMetaData
    include Nis::Util::Assignable
    attr_accessor :currentTime, :application, :startTime, :version, :signer

    alias :current_time :currentTime
    alias :current_time= :currentTime=
    alias :start_time :startTime
    alias :start_time= :startTime=

    def self.build(attrs)
      new(attrs)
    end
  end
end
