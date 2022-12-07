class Node
    property children = Hash(String, Node).new
    property name : String
    property size : Int32
    property parent : Node?

    def initialize(@name, @parent = nil, @size = 0)
    end

    def rsize : Int32
        return @size + @children.values.map{|c| c.rsize}.sum
    end

    def print(indent = "")
        puts "#{indent} #{@size > 0 ? @size.to_s : "dir"} #{name}"
        @children.values.each do |c|
            c.print(indent + "  ")
        end
    end
end

lines = File.open("input.txt").gets_to_end.lines

root = Node.new("/")
dirs = [root]
curr = root
total_space = 70_000_000
space_needed = 30_000_000

lines.each do |line|
    if line == "$ cd /"
    elsif line == "$ cd .."
        curr = curr.parent.as(Node)
    elsif match = line.match(/\$ cd ([\.\w]+)/)
        curr.children[match[1]] = Node.new(match[1], curr)
        curr = curr.children[match[1]]
        dirs.push(curr)
    elsif match = line.match(/(\d+) ([\.\w]+)/)
        curr.children[match[2]] = Node.new(match[2], curr, match[1].to_i)
    end
end

puts dirs.map{|d| d.rsize}.select{|size| size <= 100_000}.sum

space_available = total_space - root.rsize
candidates = dirs.select{|d| (space_available + d.rsize) > space_needed}.sort{|d| d.rsize}
candidates = dirs.sort{|d| d.rsize}
candidates.each do |c|
    puts "#{c.name} #{c.rsize}"
end
best_candidate = candidates.sort{|d| d.rsize}.last
puts "#{best_candidate.name}, #{best_candidate.rsize}"
