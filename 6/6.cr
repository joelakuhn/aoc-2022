seq = File.open("input.txt").gets_to_end.chars

def find_unique_span(seq, len)
    return (seq.size - (len - 1)).times do |i|
        if seq[i...(i + len)].to_set.size == len
            break i + len
        end
    end
end

puts find_unique_span(seq, 4)
puts find_unique_span(seq, 14)
