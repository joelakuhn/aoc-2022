elves = File.open("input.txt").gets_to_end.split(/\r?\n\r?\n/).map do |e|
    e.split(/\r?\n/).compact_map(&.to_i?)
end

puts elves.map(&.sum).max
puts elves.map(&.sum).sort.last(3).sum
