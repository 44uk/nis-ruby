module Nis::Unit
  # @attr [String] value
  class Status
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    %w(
      UNKNOWN
      LOCKED
      UNLOCKED
      REMOTE
      ACTIVATING
      ACTIVE
      DEACTIVATING
      INACTIVE
    ).each do |status|
      define_method "#{status.downcase}?" do
        instance_variable_get(:@value) == status
      end
    end

    # @return [String]
    def to_s
      @value
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end
  end
end
