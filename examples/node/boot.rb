require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new

bnr = Nis::Struct::BootNodeRequest.new(
  metaData: {
    application: 'NIS'
  },
  endpoint: {
    protocol: 'http',
    port: 7890,
    host: 'localhost'
  },
  identity: {
    'private-key': 'a6cbd01d04edecfaef51df9486c111abb6299c764a00206eb1d01f4587491b3f',
    name: 'Alice'
  }
)

begin
  p nis.node_boot(boot_node_request: bnr)
rescue => ex
  p ex
end
