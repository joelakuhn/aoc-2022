elves = File.open("input.txt").gets_to_end.split(/\r?\n\r?\n/).map do |e|
    e.split(/\r?\n/)
    .select{|i| i != ""}
    .map(&.to_i)
end

puts elves.map{|e| e.sum}.max
puts elves.map{|e| e.sum}.sort.reverse[0..2].sum
