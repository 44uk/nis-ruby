class Nis::Request
  # @attr [String] data
  # @attr [String] signature
  # @see http://bob.nem.ninja/docs/#requestAnnounce
  class Announce
    include Nis::Mixin::Struct

    attr_accessor :data, :signature
  end
end
