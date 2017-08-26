class Nis::Struct
  # @attr [String] score
  # @see https://nemproject.github.io/#blockChainScore
  class BlockScore
    include Nis::Util::Assignable
    attr_accessor :score

    def self.build(attrs)
      new(attrs)
    end

    # @return [String]
    def to_s
      @score
    end
  end
end
