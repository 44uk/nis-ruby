require 'nis'

nis = Nis.new

block = nis.block_at_public(block_height: 890_761)

puts block.to_hash

puts nis.block_get(block_hash: 'fb5e76bf137eb27451926d29fd2b308e672e5d9ec405d9cbcd47cc0f83492cd0')
