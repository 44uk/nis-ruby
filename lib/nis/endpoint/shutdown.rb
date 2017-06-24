module Nis::Endpoint
  module Shutdown
    def shutdown
      request(:get, '/shutdown')
    end
  end
end
