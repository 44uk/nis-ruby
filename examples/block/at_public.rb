require 'nis'
Nis.logger.level = Logger::DEBUG

p nis.block_at_public(block_height: 890_761)
