require 'nis'
hr = '-' * 64

# create NIS instance
nis = Nis.new

puts nis.namespace_mosaic_definition_page(namespace: 'alice.misc')
puts hr

puts nis.namespace_root_page
puts hr
