require 'pp'
require 'nis'
_hr = '-' * 64

# create NIS instance
nis = Nis.new

incoming = nis.debug_connections_incoming

incoming[:outstanding].each do |ai|
  puts ai.to_hash
end
puts _hr

incoming[:most_recent].each do |ai|
  puts ai.to_hash
end
puts _hr



outgoing = nis.debug_connections_outgoing

outgoing[:outstanding].each do |ai|
  puts ai.to_hash
end
puts _hr

outgoing[:most_recent].each do |ai|
  puts ai.to_hash
end
puts _hr



timers = nis.debug_connections_timers
timers.each do |t|
  puts t.to_hash
end
puts _hr



syncs = nis.debug_time_synchronization
syncs.each do |sync|
  puts sync.to_hash
end
puts _hr

