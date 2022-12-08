class Node
    property children = Hash(String, Node).new
    property size : Int32
    property parent : Node?

    def initialize(@parent = nil, @size = 0)
    end

    def rsize : Int32
        @size + @children.values.map{|c| c.rsize}.sum
    end
end
total_space = 70_000_000
space_needed = 30_000_000

lines = File.open("input.txt").gets_to_end.lines

curr = root = Node.new
dirs = [root]

lines.each do |line|
    if line == "$ cd /"
    elsif line == "$ cd .."
        curr = curr.parent.as(Node)
    elsif match = line.match(/\$ cd ([\.\w]+)/)
        curr.children[match[1]] = Node.new(curr)
        curr = curr.children[match[1]]
        dirs.push(curr)
    elsif match = line.match(/(\d+) ([\.\w]+)/)
        curr.children[match[2]] = Node.new(curr, match[1].to_i)
    end
end

puts dirs.map{|d| d.rsize}.select{|size| size <= 100_000}.sum

new_space_needed = space_needed - (total_space - root.rsize)
puts dirs.select{|d| d.rsize > new_space_needed}.sort_by{|d| d.rsize}.first.rsize
