module Nis::Endpoint
  class Base
    def initialize(client, method: nil, path: nil)
      @method ||= method
      @path   ||= path
      @client = client
    end

    def request(params = nil)
      @client.request(method, path, params)
    end

    def self.method(method)
      define_method :method do
        @method ||= method
      end
    end

    def self.path(path)
      define_method :path do
        @path ||= path
      end
    end
  end
end
