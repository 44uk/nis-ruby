class Nis::Struct
  # @attr [String] path
  # @attr [Integer] startTime
  # @attr [String] host
  # @attr [Integer] elapsedTime
  # @attr [String] id
  # @see http://bob.nem.ninja/docs/#auditInfo
  class AuditInfo
    include Nis::Util::Assignable
    attr_accessor :path, :startTime, :host, :elapsedTime, :id

    alias :start_time :startTime
    alias :start_time= :startTime=
    alias :elapsed_time :elapsedTime
    alias :elapsed_time= :elapsedTime=

    def self.build(attrs)
      attrs[:startTime] = attrs[:'start-time']
      attrs[:elapsedTime] = attrs[:'elapsed-time']
      new(attrs)
    end
  end
end
