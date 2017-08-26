class Nis::Struct
  # @attr [String] data
  # @attr [String] signature
  # @see https://nemproject.github.io/#requestAnnounce
  class RequestAnnounce
    include Nis::Util::Assignable
    attr_accessor :data, :signature

    def self.build(attrs)
      new(attrs)
    end
  end
end
