module Nis::Unit
  class Status
    attr :value

    def initialize(value)
      @value = value
    end

    %w[
      UNKNOWN
      LOCKED
      UNLOCKED
      REMOTE
      ACTIVATING
      ACTIVE
      DEACTIVATING
      INACTIVE
    ].each do |status|
      define_method "#{status.downcase}?" do
        instance_variable_get(:@value) == status
      end
    end

    def to_s
      @value
    end

    def ==(other)
      @value == other.value
    end
  end
end
