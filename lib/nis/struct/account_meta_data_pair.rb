class Nis::Struct
  # @attr [AccountInfo] address
  # @attr [AccountMetaData] meta
  # @see http://bob.nem.ninja/docs/#accountMetaDataPair
  class AccountMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :account, :meta

    def self.build(account:, meta:)
      new(
        account: AccountInfo.build(account),
        meta: AccountMetaData.build(meta)
      )
    end
  end
end
