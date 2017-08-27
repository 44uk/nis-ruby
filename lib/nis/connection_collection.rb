class Nis
  class ConnectionCollection
    def initialize(connections)
      # sort by priority
      @connections = connections
    end

    def current
      @connections.last
    end

    def next!
      raise Nis::EmptyConnectionCollection.new if @connections.size == 1
      @connections.pop
      current
    end
  end
end
