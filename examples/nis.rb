require 'nis'
Nis.logger.level = Logger::DEBUG

# Create NIS instance.
# By default, connect to local NIS.
# You also can connect to remote.
nis = Nis.new(host: '104.128.226.60')

# API path /heartbeat, /status are mapped into methods.
# It returns Nis::Struct::NemRequestResult object.
p nis.heartbeat.inspect
p nis.status.inspect

# Also call Nis#request method.
# The method receive [HTTP Method], [API Path], [Parameters]
# It returns hash which converted API JSON response.

# Nis#request returns hash,
p nis.request :get, 'heartbeat'
p nis.request :get, 'status'

# Nis#request! can raise Error when NIS returns error.
p nis.request! :get, 'account/get', address: 'INVALID_ADDRESS'

# only accept local node
# nis = Nis.new
# nis.shutdown
