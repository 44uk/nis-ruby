require 'nis'
hr = '-' * 64

nis = Nis.new

ns_mosaics = nis.namespace_mosaic_definition_page(namespace: 'alice.misc')
puts ns_mosaics.first.to_hash
puts hr

ns_root = nis.namespace_root_page
puts ns_root.first.to_hash
puts hr
