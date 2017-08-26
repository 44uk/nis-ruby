class Nis::Struct
  # @attr [Integer] modificationType
  # @attr [String] cosignatoryAccount
  # @see https://nemproject.github.io/#multisigCosignatoryModification
  class MultisigCosignatoryModification
    include Nis::Util::Assignable
    attr_accessor :modificationType, :cosignatoryAccount

    alias modification_type modificationType
    alias cosignatory_account cosignatoryAccount

    TYPE_ADD    = 0x0001
    TYPE_DELETE = 0x0002

    def self.build(attrs)
      new(attrs)
    end
  end
end
