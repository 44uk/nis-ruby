class Nis::Struct
  # @attr [Nis::Struct::NodeInfo] node
  # @attr [Integer] syncs
  # @attr [Nis::Struct::NodeExperience] experience
  # @see http://bob.nem.ninja/docs/#extendedNodeExperiencePair
  class ExtendedNodeExperiencePair
    include Nis::Util::Assignable
    attr_accessor :node, :syncs, :experiences

    def self.build(attrs)
      new(attrs)
    end
  end
end
