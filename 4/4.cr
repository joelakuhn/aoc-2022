elves = File.open("input.txt").gets_to_end.lines.map do |line|
  line.split(",").map{|e| e.split("-").map(&.to_i) }
end

overlaps_1 = elves.select do |e|
  (e[0][0] >= e[1][0] && e[0][1] <= e[1][1]) || (e[1][0] >= e[0][0] && e[1][1] <= e[0][1])
end

puts overlaps_1.size

overlaps_2 = elves.select do |e|
  (e[0][0] >= e[1][0] && e[0][0] <= e[1][1]) \
  || (e[1][0] >= e[0][0] && e[1][0] <= e[0][1]) \
  || (e[0][1] >= e[1][0] && e[0][1] <= e[1][1]) \
  || (e[1][1] >= e[0][0] && e[1][1] <= e[0][1])
end

puts overlaps_2.size
