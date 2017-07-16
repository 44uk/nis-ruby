require 'nis'

nis = Nis.new(host: 'localhost')

# only accept local node
nis.shutdown
