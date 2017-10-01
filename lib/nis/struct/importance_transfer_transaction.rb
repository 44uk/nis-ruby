class Nis::Struct
  # @attr [Integer] mode
  # @attr [String]  remote_account
  class ImportanceTransferTransaction < Transaction
    attr_accessor :mode, :remoteAccount

    alias :remote_account :remoteAccount
    alias :remote_account= :remoteAccount=
  end
end
