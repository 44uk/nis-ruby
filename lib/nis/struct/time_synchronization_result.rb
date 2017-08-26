class Nis::Struct
  # @attr [Time] dateTime
  # @attr [Integer] currentTimeOffset
  # @attr [Integer] change
  # @see https://nemproject.github.io/#timeSynchronizationResult
  class TimeSynchronizationResult
    include Nis::Util::Assignable
    attr_accessor :dateTime, :currentTimeOffset, :change

    alias :datetime :dateTime
    alias :datetime= :dateTime=
    alias :current_time_offset :currentTimeOffset
    alias :current_time_offset= :currentTimeOffset=

    def self.build(attrs)
      attrs[:dateTime] = Time.parse(attrs[:dateTime])
      new(attrs)
    end
  end
end
