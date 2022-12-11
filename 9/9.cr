lines = File.open("input.txt").gets_to_end.lines

class Point
  property x = 0
  property y = 0
end

def simulate(lines, length)
  rope = Array(Point).new(length) { Point.new }
  visited = Set(Tuple(Int32, Int32)).new

  lines.each do |line|
    direction, distance = line.split(" ")

    distance.to_i.times do
      case direction
      when "U" then rope.last.y += 1
      when "D" then rope.last.y -= 1
      when "L" then rope.last.x -= 1
      when "R" then rope.last.x += 1
      end

      (length - 2).downto(0) do |i|
        head = rope[i + 1]
        tail = rope[i]

        x_abs = (head.x - tail.x).abs
        y_abs = (head.y - tail.y).abs
        x_sign = (head.x - tail.x).sign
        y_sign = (head.y - tail.y).sign

        if x_abs == 2
          tail.x += x_sign
          tail.y += y_sign if y_abs > 0
        elsif y_abs == 2
          tail.y += y_sign
          tail.x += x_sign if x_abs > 0
        end

        if i == 0
          visited.add({tail.x, tail.y})
        end
      end
    end
  end
  return visited.size
end

puts simulate(lines, 2)
puts simulate(lines, 10)
