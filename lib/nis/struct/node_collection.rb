class Nis::Struct
  # @attr [Array] inactive
  # @attr [Array] active
  # @attr [Array] busy
  # @attr [Array] failure
  # @see http://bob.nem.ninja/docs/#nodeCollection
  class NodeCollection
    include Nis::Util::Assignable
    attr_accessor :inactive, :active, :busy, :failure

    def self.build(attrs)
      new(
        inactive: attrs[:inactive].map { |n| NodeInfo.build(n) },
        active:   attrs[:active].map { |n| NodeInfo.build(n) },
        busy:     attrs[:busy].map { |n| NodeInfo.build(n) },
        failure:  attrs[:failure].map { |n| NodeInfo.build(n) }
      )
    end
  end
end
