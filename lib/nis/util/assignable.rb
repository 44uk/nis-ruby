module Nis::Util
  module Assignable
    def initialize(attributes = {})
      attributes.each do |k, v|
        send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
      end if attributes
      yield self if block_given?
    end

    def to_hash
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete("@").to_sym] = instance_variable_get(var)
      end
    end

    def to_json
      to_hash.to_json
    end
  end
end
