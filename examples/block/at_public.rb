require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

p nis.block_at_public(block_height: 890_761)
