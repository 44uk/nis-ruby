class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [String] error
  # @attr [String] message
  # @attr [Integer] status
  # @see https://nemproject.github.io/#error-object
  class Error
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :error, :message, :status

    alias :timestamp :timeStamp
    alias :timestamp= :timeStamp=

    def self.build(attrs)
      new(attrs)
    end
  end
end
