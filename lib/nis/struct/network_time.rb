class Nis::Struct
  # @attr [Integer] sendTimeStamp
  # @attr [Integer] receiveTimeStamp
  class NetworkTime
    include Nis::Util::Assignable
    attr_accessor :sendTimeStamp, :receiveTimeStamp

    alias :send_timestamp :sendTimeStamp
    alias :send_timestamp= :sendTimeStamp=
    alias :receive_timestamp :receiveTimeStamp
    alias :receive_timestamp= :receiveTimeStamp=

    def self.build(attrs)
      new(attrs)
    end
  end
end
