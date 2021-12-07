file_data = File.read("example1.csv").split(',').map(&:to_i)

puts 'welcome to day 7!'


# find the median to get the one everyone's closest to
n = file_data.size
puts n
median_index = n/2.floor
median = file_data[median_index]
puts "the median is #{median}"
fuel = 0
file_data.each do |starting_position|
  if (starting_position > median)
    fuel += starting_position - median
  else
    fuel += median - starting_position
  end
end

puts "we need #{fuel} fuel to align"

puts "~~~ Part 2 ~~~"

average = file_data.sum.fdiv(n).ceil
puts average
puts "the average is #{average}"
new_fuel = 0
file_data.each do |starting_position|
  if (starting_position > average)
    difference = starting_position - average
  else
    difference = average - starting_position
  end
  spending = (difference ** 2 + difference) / 2
  puts spending
  new_fuel += spending
end

puts "we now need #{new_fuel} fuel to align"
