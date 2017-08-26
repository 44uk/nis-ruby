class Nis::Struct
  # @attr [Array] inactive
  # @attr [Array] active
  # @attr [Array] busy
  # @attr [Array] failure
  # @see https://nemproject.github.io/#nodeCollection
  class NodeCollection
    include Nis::Util::Assignable
    attr_accessor :inactive, :active, :busy, :failure

    def self.build(attrs)
      new(
        inactive: attrs[:inactive].map { |n| Node.build(n) },
        active:   attrs[:active].map { |n| Node.build(n) },
        busy:     attrs[:busy].map { |n| Node.build(n) },
        failure:  attrs[:failure].map { |n| Node.build(n) }
      )
    end
  end
end
