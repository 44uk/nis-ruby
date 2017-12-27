require 'nis'
Nis.logger.level = Logger::DEBUG

# TODO: ----

nis = Nis.new(host: '104.128.226.60')

FIXTURES_PATH = File.expand_path('../../spec/fixtures', __FILE__)

tx = nis.transaction_get(hash: '3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f')
file = File.open("#{FIXTURES_PATH}/nemLogoV2 -- Apostille TX 3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f -- Date 2017-10-04.png")

apa = Nis::ApostilleAudit.new(file, tx)
p apa.valid?
