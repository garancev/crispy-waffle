file_data_1 = File.readlines("example1.csv").map(&:chomp)
file_data_2 = File.readlines("example2.csv").map(&:chomp)

puts 'welcome to day 11!'

def ready_to_flash(level)
  level > 9
end

def has_flashed(level)
  level == -1
end

def increase_level(level)
  return level if level.negative?

  return [level + 1, 10].min
end

def is_not_first_row?(index)
  index.positive?
end

def is_not_first_column?(index)
  index.positive?
end

def is_not_last_column?(index, octopi_map)
  index < octopi_map[0].size - 1
end

def is_not_last_row?(index, octopi_map)
  index < octopi_map.size - 1
end

def increase_adjacent_octopi(octopi_map, row_index, col_index)
  if is_not_first_row?(row_index)
    octopi_map[row_index - 1][col_index] = increase_level(octopi_map[row_index - 1][col_index])
    if is_not_first_column?(col_index)
      octopi_map[row_index - 1][col_index - 1] = increase_level(octopi_map[row_index - 1][col_index - 1])
    end
    if is_not_last_column?(col_index, octopi_map)
      octopi_map[row_index - 1][col_index + 1] = increase_level(octopi_map[row_index - 1][col_index + 1])
    end
  end
  if is_not_last_row?(row_index, octopi_map)
    octopi_map[row_index + 1][col_index] = increase_level(octopi_map[row_index + 1][col_index])
    if is_not_first_column?(col_index)
      octopi_map[row_index + 1][col_index - 1] = increase_level(octopi_map[row_index + 1][col_index - 1])
    end
    if is_not_last_column?(col_index, octopi_map)
      octopi_map[row_index + 1][col_index + 1] = increase_level(octopi_map[row_index + 1][col_index + 1])
    end
  end
  if is_not_first_column?(col_index)
    octopi_map[row_index][col_index - 1] = increase_level(octopi_map[row_index][col_index - 1])
  end
  if is_not_last_column?(col_index, octopi_map)
    octopi_map[row_index][col_index + 1] = increase_level(octopi_map[row_index][col_index + 1])
  end
end

def everyone_increases_by_1(octopi_map)
  octopi_map.each_with_index do |row, row_index|
    row.each_with_index do |level, col_index|
      octopi_map[row_index][col_index] = increase_level(level)
    end
  end
  octopi_map
end

def reset_octopi_levels(octopi_map)
  octopi_map.each_with_index do |row, row_index|
    row.each_with_index do |level, col_index|
      if has_flashed(level)
        octopi_map[row_index][col_index] = 0
      end
    end
  end

  octopi_map
end

def run_single_step(energy, total)
  flashes = 0
  energy = everyone_increases_by_1(energy)

  loop do
    no_new_flash = 0
    energy.each_with_index do |row, row_index|
      row.each_with_index do |level, col_index|
        if ready_to_flash(level)
          flashes += 1
          energy[row_index][col_index] = -1
          increase_adjacent_octopi(energy, row_index, col_index)
        else
          no_new_flash += 1
        end
      end
    end
    if no_new_flash == total
      break
    end
  end

  energy = reset_octopi_levels(energy)

  puts "#{energy}"
  flashes
end

def process_x_times(file_data, times, total)
  octopuses_energy = file_data.map{ |line| line.split('').map(&:to_i)}
  flashes = 0
  for x in 1..times do
    flashes += run_single_step(octopuses_energy, total)
  end

  puts "There were #{flashes} flashes during this step"

  puts "#{octopuses_energy}"
end

def process_until_sync(file_data, total)
  octopuses_energy = file_data.map{ |line| line.split('').map(&:to_i)}
  steps = 0
  loop do
    steps += 1
    flashes_in_one_step = run_single_step(octopuses_energy, total)
    if flashes_in_one_step === total
      break
    end
  end

  puts "There were #{steps} steps until everyone flashes together"

  puts "#{octopuses_energy}"
end

process_x_times(file_data_1, 2, 25)
process_x_times(file_data_2, 100, 100)
process_until_sync(file_data_2, 100)

