map = File.open("input.txt").gets_to_end.lines.map{|l| l.chars}.to_a

height = map.size
width = map[0].size

vis_count = 0

height.times do |y|
    width.times do |x|
        visible = \
           x == 0 || y == 0 || x == (width - 1) || y == (height - 1) \
        || (0...x).all?{|dx| map[y][dx] < map[y][x]} \
        || (x+1...width).all?{|dx| map[y][dx] < map[y][x]} \
        || (0...y).all?{|dy| map[dy][x] < map[y][x]} \
        || (y+1...height).all?{|dy| map[dy][x] < map[y][x]}
        vis_count += 1 if visible
    end
end

max_scenic_score = 0

height.times do |y|
    width.times do |x|
        left = 0
        (0...x).to_a.reverse.each{|dx| left += 1; break if map[y][dx] >= map[y][x]}
        right = 0
        (x+1...width).each{|dx| right += 1; break if map[y][dx] >= map[y][x]}
        top = 0
        (0...y).to_a.reverse.each{|dy| top += 1; break if map[dy][x] >= map[y][x]}
        bottom = 0
        (y+1...height).each{|dy| bottom += 1; break if map[dy][x] >= map[y][x]}
        scenic_score = left * right * top * bottom
        if scenic_score > max_scenic_score
            max_scenic_score = scenic_score
        end
    end
end

puts vis_count
puts max_scenic_score
