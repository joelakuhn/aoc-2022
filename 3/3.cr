packs = File.open("input.txt").gets_to_end.lines.map(&.chars)

def pri(c)
  c >= 'a' ? (c.ord - 'a'.ord + 1)  : (c.ord - 'A'.ord + 27)
end

puts (packs.sum do |p|
  left, right = p[0...(p.size // 2)].to_set, p[(p.size // 2)...p.size].to_set
  pri((left & right).first)
end)

puts (packs.in_groups_of(3, [] of Char).sum do |g|
  a, b, c = g[0].to_set, g[1].to_set, g[2].to_set
  pri((a & b & c).first)
end)
