class Nis::Struct
  # @attr [Integer] s
  # @attr [Integer] f
  # @see http://bob.nem.ninja/docs/#
  class NodeExperience
    include Nis::Util::Assignable
    attr_accessor :s, :f

    def self.build(attrs)
      new(attrs)
    end
  end
end
