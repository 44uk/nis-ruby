class Nis::Struct
  # @attr [Array] modifications
  # @attr [Hash] minCosignatories
  class MultisigAggregationModificationTransaction < Transaction
    attr_accessor :modifications, :minCosignatories

    alias :min_cosignatories :minCosignatories
    alias :min_cosignatories= :minCosignatories=
  end
end
