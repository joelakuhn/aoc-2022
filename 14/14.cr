lines = File.open("input.txt").gets_to_end.lines

sensors = [] of Tuple(Int32, Int32)
beacons = [] of Tuple(Int32, Int32)

line = 10

lines.each do |l|
  m = l.match(/Sensor at x=([-\d]+), y=([-\d]+): closest beacon is at x=([-\d]+), y=([-\d]+)/).as(Regex::MatchData)
  sensors.push({ m[1].to_i, m[2].to_i })
  beacons.push({ m[3].to_i, m[4].to_i })
end

def find_covered_regions(sensors, beacons, line)
  regions = sensors.zip(beacons).compact_map do |s, b|
    dist = (s[0] - b[0]).abs + (s[1] - b[1]).abs
    y_offset = (s[1] - line).abs
    if dist < y_offset
      nil
    else
      { s[0] - (dist - y_offset), s[0] + (dist - y_offset) }
    end
  end.sort_by{|r| r[0]}
  return regions
end

def count_reachable(sensors, beacons, line)
  regions = find_covered_regions(sensors, beacons, line)

  hit = Set(Int32).new
  regions.each do |r|
    (r[0]..r[1]).each do |p|
      hit.add(p)
    end
  end
  beacons_on_line = beacons.select{|b| b[1] == line}.to_set.size
  return hit.size - beacons_on_line
end

def find_unreachable(sensors, beacons, max_line)
  (0..max_line).each do |line|
    i = 0
    find_covered_regions(sensors, beacons, line).each do |r|
      if i >= r[0] && i <= r[1]
        i = r[1] + 1
      elsif i < r[0]
        return i.to_u64 * 4_000_000u64 + line.to_u64
      end
    end
  end
end

puts count_reachable(sensors, beacons, 2_000_000)
puts find_unreachable(sensors, beacons, 4_000_000)

