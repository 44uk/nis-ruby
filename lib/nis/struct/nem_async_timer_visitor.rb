class Nis::Struct
  # @attr [String] last_delay_time
  # @attr [String] executions
  # @attr [String] failures
  # @attr [String] successes
  # @attr [String] last_operation_start_time
  # @attr [String] is_executing
  # @attr [String] name
  # @attr [String] average_operation_time
  # @attr [String] last_operation_time
  # @see https://nemproject.github.io/#nemAsyncTimerVisitor
  class NemAsyncTimerVisitor
    include Nis::Util::Assignable
    attr_accessor :last_delay_time, :executions, :failures, :successes, :last_operation_start_time, :is_executing, :name, :average_operation_time, :last_operation_time

    def self.build(attrs)
      attrs[:last_delay_time] = attrs[:'last-delay-time']
      attrs[:last_operation_start_time] = attrs[:'last-operation-start-time']
      attrs[:is_executing] = attrs[:'is-executing']
      attrs[:average_operation_time] = attrs[:'average-operation-time']
      attrs[:last_operation_time] = attrs[:'last-operation-time']
      new(attrs)
    end

    # @return [Boolean]
    def executing?
      @is_executing == 1
    end
  end
end
