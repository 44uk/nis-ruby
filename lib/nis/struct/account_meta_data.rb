class Nis::Struct
  # @attr [String] status
  # @attr [String] remoteStatus
  # @attr [Array <Nis::Struct::AccountInfo>] cosignatoryOf
  # @attr [Array <Nis::Struct::AccountInfo>] cosignatories
  # @see http://bob.nem.ninja/docs/#accountMetaData
  class AccountMetaData
    include Nis::Util::Assignable
    attr_accessor :status, :remoteStatus, :cosignatoryOf, :cosignatories

    alias :remote_status :remoteStatus
    alias :remote_status= :remoteStatus=
    alias :cosignatory_of :cosignatoryOf
    alias :cosignatory_of= :cosignatoryOf=

    def self.build(attrs)
      attrs[:status] = Nis::Unit::Status.new(attrs[:status])
      attrs[:remoteStatus] = Nis::Unit::Status.new(attrs[:remoteStatus])
      attrs[:cosignatoryOf] = attrs[:cosignatoryOf].map { |a| AccountInfo.build(a) }
      attrs[:cosignatories] = attrs[:cosignatories].map { |a| AccountInfo.build(a) }
      new(attrs)
    end

    # @return [Boolean]
    def unknown?
      @status == 'UNKNOWN'
    end

    # @return [Boolean]
    def locked?
      @status == 'LOCKED'
    end

    # @return [Boolean]
    def unlocked?
      @status == 'UNLOCKED'
    end
  end
end
