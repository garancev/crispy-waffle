require 'json'
file_data_1 = File.readlines("example1.csv").map(&:chomp)

puts 'welcome to day 13!'

def is_pair_in_order?(left, right)
  if !left.nil? && right.nil?
    puts "Right side ran out of items, so inputs are NOT in the right order"
    return -1
  end
  puts " - Compare #{left.inspect} vs. #{right.inspect}"
  if left.is_a?(Integer) && right.is_a?(Integer)
    if left < right
      puts "Left side is smaller, so inputs are in the right order"
      return 1
    elsif left > right
      puts "left is bigger, so inputs are NOT in the right order"
      return -1
    end
  end
  if left.is_a?(Array) && right.is_a?(Array)
    left.each_with_index do |value, index|
      in_order = is_pair_in_order?(value, right[index])
      if !in_order.zero?
        return in_order
      end
    end
    if !right[left.size].nil?
      puts "Left side ran out of items, so inputs are in the right order"
      return 1
    end

  end

  if left.is_a?(Array) && right.is_a?(Integer)
    puts " - Mixed types; Convert right to #{[right].inspect} & retry"
    return is_pair_in_order?(left, [right])
  end
  if left.is_a?(Integer) && right.is_a?(Array)
    puts " - Mixed types; Convert left to #{[left].inspect} & retry"
    return is_pair_in_order?([left], right)
  end
  return 0
end

def format_packets(pairs)
  pairs
    .reject { |s| s.empty? }
    .map{|value| JSON.parse(value)}
end

def sum_indices(pairs)
  ordered_indices = []
  format_packets(pairs)
    .each_slice(2)
    .each_with_index do |pair, index|
    puts "== Pair #{index + 1} =="
    ordered_indices << index + 1 if is_pair_in_order?(pair[0], pair[1])
  end
  ordered_indices.inject(:+)
end
# a1 = a.sort {|a, b| a <=> b }

def find_decoder_key(pairs)
  divider_1 = [[2]]
  divider_2 = [[6]]
  formatted_packets = format_packets(pairs)
  formatted_packets << divider_1
  formatted_packets << divider_2
  sorted_packets = formatted_packets.sort{ |a, b| is_pair_in_order?(a, b)}
  sorted_packets.reverse!
  index_1 = sorted_packets.index(divider_1) + 1
  index_2 = sorted_packets.index(divider_2) + 1
  index_1 * index_2
end
puts 'What is the sum of the indices of those pairs?'
puts sum_indices(file_data_1)

puts "~~~ and what is the decoder key for the distress signal? ~~~"
puts find_decoder_key(file_data_1)
