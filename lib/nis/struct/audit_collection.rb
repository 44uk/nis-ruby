class Nis::Struct
  # @attr [Array] outstanding
  # @attr [Array] mostRecent
  # @see https://nemproject.github.io/#auditCollection
  class AuditCollection
    include Nis::Util::Assignable
    attr_accessor :outstanding, :mostRecent

    alias :most_recent :mostRecent
    alias :most_recent= :mostRecent=

    def self.build(outstanding:, most_recent:)
      new(
        outstanding: outstanding.map { |audt| Nis::Struct::AuditInfo.build(audt) },
        mostRecent: most_recent.map { |audt| Nis::Struct::AuditInfo.build(audt) }
      )
    end
  end
end
