map = File.open("input.txt").gets_to_end.lines.map{|l| l.chars.map{|c| c.ord - 'a'.ord}}

class Solver
  property map : Array(Array(Int32))
  property visited : Array(Array(Bool))
  property memo : Array(Array(Int32))
  property start = {0, 0}
  property term = {0, 0}
  property best = 100000
  property part_2 = false

  def initialize(@map)
    @visited = Array(Array(Bool)).new(@map.size) { Array(Bool).new(@map[0].size) { false } }
    @memo = Array(Array(Int32)).new(@map.size) { Array(Int32).new(@map[0].size) { 10000 } }

    @map.size.times do |y|
      @map[y].size.times do |x|
        if @map[y][x] == 'S'.ord - 'a'.ord
          @start = {x, y}
          map[y][x] = 0
        elsif @map[y][x] == 'E'.ord - 'a'.ord
          @term = {x, y}
          map[y][x] = 25
        end
      end
    end
  end

  def find_exit(x = start[0], y = @start[1], steps = 0)
    if steps > 0 && @map[y][x] == 0
      return
    elsif steps >= @memo[y][x]
      return
    else
      @memo[y][x] = steps
    end

    return if steps >= @best
    if x == @term[0] && y == @term[1]
      @best = steps
    end

    @visited[y][x] = true

    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}].each do |dx, dy|
      new_x = x + dx
      new_y = y + dy
      if new_x >= 0 && new_x < @map[0].size && new_y >= 0 && new_y < @map.size
        if !@visited[new_y][new_x]
          if (map[new_y][new_x] - map[y][x] <= 1)
            find_exit(new_x, new_y, steps + 1)
          end
        end
      end
    end

    @visited[y][x] = false
  end
end


s = Solver.new(map.clone);
s.find_exit()
puts s.best

shortest = 10000
map.size.times do |y|
  map[0].size.times do |x|
    if map[y][x] == 0
      s = Solver.new(map.clone);
      s.part_2 = true
      s.find_exit(x, y)
      if s.best < shortest
        shortest = s.best
      end
    end
  end
end

puts shortest
