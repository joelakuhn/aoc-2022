graph_in, moves_in = File.open("input.txt").gets_to_end.split("\n\n")

stacks = [] of Array(Char)
graph_in.lines.each do |line|
    line.chars.in_groups_of(4, ' ').each_with_index do |item, i|
        if item[0] == '['
            until stacks.size > i
                stacks.push([] of Char)
            end
            stacks[i].unshift(item[1])
        end
    end
end

moves = moves_in.lines.compact_map do |line|
    match = line.match(/move (\d+) from (\d+) to (\d+)/)
    if !match.nil?
        ({ match[1].to_i, match[2].to_i - 1, match[3].to_i - 1, })
    end
end

stacks1 = stacks.clone
moves.each do |count, from, to|
    count.times do
        stacks1[to].push(stacks1[from].pop)
    end
end

stacks2 = stacks.clone
moves.each do |count, from, to|
    stacks2[to].concat(stacks2[from].pop(count))
end

puts stacks1.map{|s| s.last}.join
puts stacks2.map{|s| s.last}.join
