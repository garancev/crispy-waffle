# file_data = File.read("example1.csv").split

file_data = File.readlines("example1.csv")
# puts file_data
calories_per_elf = [[]]
elves_count = 0
file_data.each do |calories|
  if calories == "\n"
    # puts "new elf"
    calories_per_elf.append([])
    elves_count = elves_count + 1
  else
    calories_per_elf[elves_count].append(calories.to_i)
  end
end

total_calories_per_elf = calories_per_elf.map do |elf|
  elf.reduce(0) { |sum, calories| sum + calories }
end


puts "The elf with the most calories has #{total_calories_per_elf.max} calories"
# puts increments

# puts '~~~~ sliding increments ~~~~'

# measurement_windows = []
# file_data.each_with_index do |depth, index|
#   puts index
#   next unless index >= 2
#   puts index
#   sum = file_data[index - 2].to_i + file_data[index - 1].to_i + depth.to_i
#   measurement_windows.push(sum)
# end

# increments_by_window = 0

# puts measurement_windows
# measurement_windows.each_with_index do |depth, index|
#   next if index == 0
#   difference_with_previous =  depth - measurement_windows[index - 1]
#    if difference_with_previous > 0
#     increments_by_window = increments_by_window + 1
#    end
# end

# puts increments_by_window