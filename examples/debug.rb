require 'nis'

nis = Nis.new

incoming = nis.debug_connections_incoming

incoming[:outstanding].each do |ai|
  puts ai.to_hash
end

incoming[:most_recent].each do |ai|
  puts ai.to_hash
end

outgoing = nis.debug_connections_outgoing

outgoing[:outstanding].each do |ai|
  puts ai.to_hash
end

outgoing[:most_recent].each do |ai|
  puts ai.to_hash
end

timers = nis.debug_connections_timers
timers.each do |t|
  puts t.to_hash
end

syncs = nis.debug_time_synchronization
syncs.each do |sync|
  puts sync.to_hash
end
