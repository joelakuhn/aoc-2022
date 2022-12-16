input = File.open("input.txt").gets_to_end.chomp

class Node
  property int_val : Int32?
  property children : Array(Node)?

  def self.int_node(int_val : Int32)
    new_node = Node.new
    new_node.int_val = int_val
    return new_node
  end
  def val : Int32 | Array(Node)
    int_val.nil? ? children.as(Array(Node)) : int_val.as(Int32)
  end
  def self.packet_node(children = [] of Node)
    new_node = Node.new
    new_node.children = children
    return new_node
  end
  def push(n : Node)
    @children.as(Array(Node)).push(n)
  end
  def <=>(other : Node)
    if val.is_a?(Int32) && other.val.is_a?(Int32)
      return int_val.as(Int32) <=> other.int_val.as(Int32)
    end
    left = self
    right = other
    if val.is_a?(Int32) && !other.val.is_a?(Int32)
      left = Node.packet_node
      left.push(Node.int_node(val.as(Int32)))
    end
    if !val.is_a?(Int32) && other.val.is_a?(Int32)
      right = Node.packet_node
      right.push(Node.int_node(other.val.as(Int32)))
    end
    i = 0
    while i < left.children.as(Array(Node)).size && i < right.children.as(Array(Node)).size
      cmp = left.children.as(Array(Node))[i] <=> right.children.as(Array(Node))[i]
      if cmp != 0
        return cmp
      end
      i += 1
    end
    if i < right.children.as(Array(Node)).size
      return -1
    elsif i < left.children.as(Array(Node)).size
      return 1
    else
      return 0
    end
  end
  def to_readable
    if !int_val.nil?
      return int_val.to_s
    else
      return "[#{children.as(Array(Node)).map{|n| n.to_readable}.join(",")}]"
    end
  end
end

def parse_packet(line)
  packet = Node.packet_node
  top = packet
  stack = [] of Node
  chars = line.chars
  i = 0
  while i < line.size
    case chars[i]
    when '['
      new = Node.packet_node
      packet.push(new)
      stack.push(new)
      packet = new
      i += 1
    when ']'
      stack.pop
      if stack.size > 0
        packet = stack.last
      end
      i += 1
    when ','
      i += 1
    else
      num = ""
      while chars[i] >= '0' && chars[i] <= '9'
        num += chars[i]
        i += 1
      end
      stack.last.push(Node.int_node(num.to_i))
    end
  end
  return top.children.as(Array(Node)).first
end

part_1 = 0
chunks = input.split("\n\n")
packets = chunks.map{|chunk| chunk.split("\n").map{|l| parse_packet(l)}}
packets.each_with_index do |p, i|
  cmp = p[0] <=> p[1]
  if cmp == -1
    part_1 += i + 1
  end
end

puts part_1

div_2 = Node.packet_node([ Node.packet_node([ Node.int_node(2) ]) ])
div_6 = Node.packet_node([ Node.packet_node([ Node.int_node(6) ]) ])
all_packets = packets.concat([[ div_2, div_6]]).flatten.sort
index_2 = 0
index_6 = 0
all_packets.each_with_index do |p, i|
  if p == div_2
    index_2 = i + 1
  elsif p == div_6
    index_6 = i + 1
  end
end
puts index_2 * index_6
