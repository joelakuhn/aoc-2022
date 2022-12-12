sections = File.open("input.txt").gets_to_end.split("\n\n")

class Monkey
  property items = [] of UInt64
  property op = ""
  property amount = 0
  property divisor = 0
  property true_target = 0
  property false_target = 0

  def self.from_s(lines)
    new = Monkey.new
    new.items = lines[1].split(": ").last.split(", ").map(&.to_u64)
    op_s, amount_s = lines[2].split(" old ").last.split(" ")
    if op_s == "*" && amount_s == "old"
      new.op = "square"
    elsif op_s == "+" && amount_s == "old"
      new.op = "double"
    else
      new.op = op_s
      new.amount = amount_s.to_i
    end
    new.divisor = lines[3].split(" ").last.to_i
    new.true_target = lines[4].split(" ").last.to_i
    new.false_target = lines[5].split(" ").last.to_i
    return new
  end
end

def run(monkeys, rounds, reduce_worry?)
  counts = Array(UInt64).new(monkeys.size, 0u64)
  lcm = monkeys.map(&.divisor).reduce{|acc, d| acc.lcm(d)}

  rounds.times do |i|
    monkeys.each_with_index do |m, i|
      counts[i] += m.items.size

      m.items.each do |worry|
        worry = case m.op
        when "*" then worry * m.amount
        when "+" then worry + m.amount
        when "double" then worry + worry
        when "square" then worry * worry
        else 0_u64
        end

        if reduce_worry?
          worry //= 3
        end
        worry %= lcm

        if worry % m.divisor == 0
          monkeys[m.true_target].items.push(worry)
        else
          monkeys[m.false_target].items.push(worry)
        end
      end

      m.items.clear()
    end
  end

  return counts.sort.last(2).product
end

monkeys = sections.map{|s| Monkey.from_s(s.lines)}
puts run(monkeys, 20, true)
monkeys = sections.map{|s| Monkey.from_s(s.lines)}
puts run(monkeys, 10000, false)
