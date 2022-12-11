lines = File.open("input.txt").gets_to_end.lines.map{|l| l.split(' ')}

score_1 = 0
lines.each do |l|
  a, b = l
  case a
  when "A"
    case b
    when "X" then score_1 += 3 + 1
    when "Y" then score_1 += 6 + 2
    when "Z" then score_1 += 0 + 3
    end
  when "B"
    case b
    when "X" then score_1 += 0 + 1
    when "Y" then score_1 += 3 + 2
    when "Z" then score_1 += 6 + 3
    end
  when "C"
    case b
    when "X" then score_1 += 6 + 1
    when "Y" then score_1 += 0 + 2
    when "Z" then score_1 += 3 + 3
    end
  end
end

puts score_1

score_2 = 0
lines.each do |l|
  a, b = l
  case a
  when "A"
    case b
    when "X" then score_2 += 0 + 3
    when "Y" then score_2 += 3 + 1
    when "Z" then score_2 += 6 + 2
    end
  when "B"
    case b
    when "X" then score_2 += 0 + 1
    when "Y" then score_2 += 3 + 2
    when "Z" then score_2 += 6 + 3
    end
  when "C"
    case b
    when "X" then score_2 += 0 + 2
    when "Y" then score_2 += 3 + 3
    when "Z" then score_2 += 6 + 1
    end
  end
end

puts score_2
