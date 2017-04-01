module Nis::Util
  module Assignable
    def initialize(attributes = {})
      attributes.each do |k, v|
        send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
      end if attributes
      yield self if block_given?
    end

    # @param [Symbol, String] attr Attribute name
    # @return [Any] Attribute value
    def [](attr)
      send(attr)
    end

    # @return [Hash] Attribute and value pairs
    def to_hash
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete("@").to_sym] = instance_variable_get(var)
      end
    end

    # @return [String] JSON formatted structure
    def to_json
      to_hash.to_json
    end
  end
end
