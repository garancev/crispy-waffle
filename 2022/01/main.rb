file_data = File.readlines("input.csv")

puts 'welcome to day 1!'

def split_by_elves(data)
  calories_per_elf = [[]]
  elves_count = 0
  data.each do |calories|
    if calories == "\n"
      calories_per_elf.append([])
      elves_count = elves_count + 1
    else
      calories_per_elf[elves_count].append(calories.to_i)
    end
  end
  calories_per_elf
end

def find_calories_per_elf(data)
  calories_per_elf = split_by_elves(data)

  calories_per_elf.map do |elf|
    elf.reduce(0) { |sum, calories| sum + calories }
  end
end

puts 'how many calories for the elf with the most food?'

puts find_calories_per_elf(file_data).max

puts '~~~~ How many calories for the top 3 elves? ~~~~'

puts find_calories_per_elf(file_data).max(3).sum
# measurement_windows = []
# measurement_windows = file_data.each_cons(3).map(&:sum)
# puts find_increments(measurement_windows)
