require 'spec_helper'

describe Nis::Struct::NemAsyncTimerVisitor do
  let(:attrs) do
    {
      last_delay_time: 3000,
      executions: 1024,
      failures: 0,
      successes: 1024,
      last_operation_start_time: 9_317_695,
      is_executing: 1,
      name: 'FORAGING',
      average_operation_time: 0,
      last_operation_time: 0
    }
  end
  let(:struct) { described_class.new(attrs) }

  subject { struct }

  describe '#executing?' do
    it { expect(subject.executing?).to be true }
  end
end
