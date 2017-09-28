require 'nis'
Nis.logger.level = Logger::DEBUG

p nis.block_get(block_hash: 'fb5e76bf137eb27451926d29fd2b308e672e5d9ec405d9cbcd47cc0f83492cd0')
