class Nis::Struct
  # @attr [Integer] s
  # @attr [Integer] f
  # @see https://nemproject.github.io/#
  class NodeExperience
    include Nis::Util::Assignable
    attr_accessor :s, :f

    def self.build(attrs)
      new(attrs)
    end
  end
end
