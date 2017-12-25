require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '104.128.226.60')

p nis.mosaic_supply(mosaic_id: 'nembar:vip')
