require 'nis'

# Create NIS instance.
# By default, connect to local NIS.
# You also can connect to remote.
#   Nis.new(host: '50.3.87.123')
nis = Nis.new

# API path /heartbeat, /status are mapped into methods.
# It returns Nis::Struct::NemRequestResult object.
puts nis.heartbeat.inspect
puts nis.status.inspect

# Also call Nis#request method.
# The method receive [HTTP Method], [API Path], [Parameters]
# It returns hash which converted API JSON response.

# Nis#request returns hash,
puts nis.request :get, 'heartbeat'
puts nis.request :get, 'status'

# Nis#request! can raise Error when NIS returns error.
puts nis.request! :get, 'account/get', address: 'INVALID_ADDRESS'
