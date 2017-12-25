require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

p nis.namespace_mosaic_definition_page(namespace: 'alice.misc')
