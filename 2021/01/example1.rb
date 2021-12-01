file_data = File.read("example1.csv").split


file_data.each { |line| puts line }

increments = 0

file_data.each_with_index do |depth, index|
  next if index == 0
  difference_with_previous =  depth.to_i - file_data[index - 1].to_i
   if difference_with_previous > 0
    increments = increments + 1
   end
end

puts increments

puts '~~~~ sliding increments ~~~~'

example2 = File.read("example2.csv").split
measurement_windows = []
example2.each_with_index do |depth, index|
  puts index
  next unless index >= 2
  puts index
  sum = example2[index - 2].to_i + example2[index - 1].to_i + depth.to_i
  measurement_windows.push(sum)
end

increments_by_window = 0

puts measurement_windows
measurement_windows.each_with_index do |depth, index|
  next if index == 0
  difference_with_previous =  depth - measurement_windows[index - 1]
   if difference_with_previous > 0
    increments_by_window = increments_by_window + 1
   end
end

puts increments_by_window