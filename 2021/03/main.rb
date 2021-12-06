file_data = File.read("input.csv").split

puts 'welcome to day 3!'
split_data = file_data.map do |diagnostic|
  diagnostic.split('')
end

gamma_rate = ''
epsilon_rate = ''
split_data.transpose.each do |diagnostic|
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

def sum_at_index(diagnostics, index)
  reordered_diagnostics = diagnostics.transpose
  total_0 = reordered_diagnostics[index].count('0')
  total_1 = reordered_diagnostics[index].count('1')

  [total_0, total_1]
end

def keep_according_to_most_bit(diagnostics, index)
  sum = sum_at_index(diagnostics, index)
  diagnostics.keep_if do |diagnostic|
    (diagnostic[index] == '0' && sum[0] > sum[1]) || (diagnostic[index] == '1' && sum[1] >= sum[0])
  end
  diagnostics
end

def keep_according_to_least_bit(diagnostics, index)
  sum = sum_at_index(diagnostics, index)
  diagnostics.keep_if do |diagnostic|
    (diagnostic[index] == '0' && sum[0] <= sum[1]) || (diagnostic[index] == '1' && sum[1] < sum[0])
  end
  diagnostics
end

oxygen_generator_rating = split_data.map(&:clone)
index = 0
while oxygen_generator_rating.size > 1 do
  oxygen_generator_rating = keep_according_to_most_bit(oxygen_generator_rating, index)
  index += 1
end

c02_scrubber_rating = split_data.map(&:clone)
index = 0
while c02_scrubber_rating.size > 1 do
  c02_scrubber_rating = keep_according_to_least_bit(c02_scrubber_rating, index)
  index += 1
end

puts 'Whats the oxygen generator rating?'
puts oxygen_generator_rating.join
puts 'Whats the c02 scrubber rating?'
puts c02_scrubber_rating.join

puts 'the life support rating is: '
puts oxygen_generator_rating.join.to_i(2) * c02_scrubber_rating.join.to_i(2)
