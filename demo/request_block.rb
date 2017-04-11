require 'nis'
hr = '-' * 64

# create NIS instance
nis = Nis.new

puts nis.block_at_public(block_height: 895492)
puts hr

puts nis.block_get(block_hash: '74998229fa8a6eebfce9bcc313c552528bf82caac6166ae05e65578b4fb1f2da')
puts hr
