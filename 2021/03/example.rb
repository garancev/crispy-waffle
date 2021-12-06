file_data = File.read("example1.csv").split

puts 'welcome to day 3!'
split_data = file_data.map do |diagnostic|
  diagnostic.split('')
end
reordered_array = split_data.transpose

gamma_rate = ''
epsilon_rate = ''
reordered_array.each do |diagnostic|
  total_0 = diagnostic.count('0')
  total_1 = diagnostic.count('1')
  if total_0 > total_1
    gamma_rate += '0'
    epsilon_rate += '1'
  else
    gamma_rate += '1'
    epsilon_rate += '0'
  end
end

puts 'Whats the gamma rate?'
puts gamma_rate
puts 'Whats the epsilon rate?'
puts epsilon_rate

puts 'the power consumption is: '
puts gamma_rate.to_i(2) * epsilon_rate.to_i(2)

puts '~~~~ second part ~~~~'


# Start with all 12 numbers and consider only the first bit of each number.
# There are more 1 bits (7) than 0 bits (5), so keep only the 7 numbers with a 1 in the first position: 11110, 10110, 10111, 10101, 11100, 10000, and 11001.
# Then, consider the second bit of the 7 remaining numbers: there are more 0 bits (4) than 1 bits (3), so keep only the 4 numbers with a 0 in the second position: 10110, 10111, 10101, and 10000.
# In the third position, three of the four numbers have a 1, so keep those three: 10110, 10111, and 10101.
# In the fourth position, two of the three numbers have a 1, so keep those two: 10110 and 10111.
# In the fifth position, there are an equal number of 0 bits and 1 bits (one each). So, to find the oxygen generator rating, keep the number with a 1 in that position: 10111.
# As there is only one number left, stop; the oxygen generator rating is 10111, or 23 in decimal.

def keep_according_to_most_bit(diagnostics, reordered_diagnostics, index)
  total_0 = reordered_diagnostics[index].count('0')
  total_1 = reordered_diagnostics[index].count('1')
  diagnostics.delete_if do |diagnostic|
    (diagnostic[index] == '0' && total_0 <= total_1) || (diagnostic[index] == '1' && total_1 < total_0)
  end
  diagnostics
end

def keep_according_to_least_bit(diagnostics, reordered_diagnostics, index)
  total_0 = reordered_diagnostics[index].count('0')
  total_1 = reordered_diagnostics[index].count('1')
  diagnostics.keep_if do |diagnostic|
    (diagnostic[index] == '0' && total_0 <= total_1) || (diagnostic[index] == '1' && total_1 < total_0)
  end
  diagnostics
end

oxygen_generator_rating = split_data.map(&:clone)
index = 0
while oxygen_generator_rating.size > 1 do
  reordered_remaining_array = oxygen_generator_rating.transpose
  oxygen_generator_rating = keep_according_to_most_bit(oxygen_generator_rating, reordered_remaining_array, index)
  index += 1
end

c02_scrubber_rating = split_data.map(&:clone)
index = 0
while c02_scrubber_rating.size > 1 do
  reordered_remaining_array = c02_scrubber_rating.transpose
  c02_scrubber_rating = keep_according_to_least_bit(c02_scrubber_rating, reordered_remaining_array, index)
  index += 1
end

puts 'Whats the oxygen generator rating?'
puts oxygen_generator_rating.join
puts 'Whats the c02 scrubber rating?'
puts c02_scrubber_rating.join

puts 'the life support rating is: '
puts oxygen_generator_rating.join.to_i(2) * c02_scrubber_rating.join.to_i(2)
