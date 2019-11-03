Matched = Struct.new(:string)

list = 10.times.map {|i| Matched.new(i.to_s) }

# puts list.inspect

a = list.reduce do |accum, l|
  accum + l.string
end

