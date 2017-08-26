class Nis::Struct
  # @attr [Nis::Struct::Node] node
  # @attr [Integer] syncs
  # @attr [Nis::Struct::NodeExperience] experience
  # @see https://nemproject.github.io/#extendedNodeExperiencePair
  class ExtendedNodeExperiencePair
    include Nis::Util::Assignable
    attr_accessor :node, :syncs, :experiences

    def self.build(attrs)
      attrs[:node] = Node.build(attrs[:node])
      new(attrs)
    end
  end
end
