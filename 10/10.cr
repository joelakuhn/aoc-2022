lines = File.open("input.txt").gets_to_end.lines

class Computer
  property reg = 1
  property tick = 0
  property signal_strength = 0
  property screen = Array(Char).new(240, '.')

  def check_signal_strength()
    @signal_strength += @tick * @reg if (@tick - 20) % 40 == 0
  end

  def draw()
    position = (@tick - 1) % 240
    screen[position] = ((position % 40) - (@reg % 40)).abs <= 1 ? '#' : '.'
  end

  def print_screen()
    @screen.in_groups_of(40, '.').map{|l| l.join}.join("\n")
  end

  def run(lines)
    lines.each do |inst|
      if inst == "noop"
        @tick += 1
        check_signal_strength()
        draw()
      else
        @tick += 1
        check_signal_strength()
        draw()
        @tick += 1
        check_signal_strength()
        draw()
        @reg += inst.split(" ").last.to_i
      end
    end
  end
end

computer = Computer.new
computer.run(lines)
puts computer.signal_strength
puts computer.print_screen
