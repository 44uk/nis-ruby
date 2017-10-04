require 'nis'
Nis.logger.level = Logger::DEBUG

nis = Nis.new(host: '23.228.67.85')

FIXTURES_PATH = File.expand_path('../../spec/fixtures', __FILE__)

tx_hash = '3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f'

tx = nis.transaction_get(hash: tx_hash)
apostille_hash = tx.transaction.message[:payload] # 'fe4e545902cde315617a435ebfd5fe8875d699e2f2363262f5'
file = File.open("#{FIXTURES_PATH}/nemLogoV2 -- Apostille TX 3d7d8a88768ea35f35a4607252ea7bb71fd0951b92a12dfab41c98333b029c9f -- Date 2017-10-04.png")

apa = Nis::ApostilleAudit.new(file, apostille_hash)
p apa.valid?
