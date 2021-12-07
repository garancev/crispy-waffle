file_data = File.read("input.csv").split(',').map(&:to_i).sort

puts 'welcome to day 7!'


# find the median to get the one everyone's closest to
n = file_data.size
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

average = file_data.sum.fdiv(n)
rounded_average = average.floor

new_fuel = 0
file_data.each do |starting_position|
  if (starting_position > rounded_average)
    difference = starting_position - rounded_average
  else
    difference = rounded_average - starting_position
  end
  new_fuel += (difference ** 2 + difference) / 2
end

puts "we now need #{new_fuel} fuel to align"
