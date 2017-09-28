require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

p nis.namespace_mosaic_definition_page(namespace: 'alice.misc')
