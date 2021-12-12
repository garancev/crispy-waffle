require 'matrix'

file_data = File.readlines("input.csv").map(&:chomp)

puts 'welcome to day 9!'

height_map_array = file_data.map{ |line| line.split('').map(&:to_i)}

def already_in_basin?(position)
  position == 9
end
def calculate_basin(row, col, basin, complete_map)
  return basin if already_in_basin?(complete_map[row][col])
  basin << complete_map[row][col]
  complete_map[row][col] = 9
  if row > 0
    calculate_basin(row - 1, col, basin, complete_map)
  end
  if col > 0
    calculate_basin(row, col - 1, basin, complete_map)
  end
  if row < complete_map.size - 1
    calculate_basin(row + 1, col, basin, complete_map)
  end
  if col < complete_map[0].size - 1
    calculate_basin(row, col + 1, basin, complete_map)
  end
  basin
end

small_numbers = []
basins = []
height_map_array.each_with_index do |height_row, row|
  height_row.each_with_index do |e, col|
    left = 10
    right = 10
    bottom = 10
    top = 10
    if row > 0
      top = height_map_array[row - 1][col]
    end
    if col > 0
      left = height_map_array[row][col - 1]
    end
    if row < height_map_array.size - 1
      bottom = height_map_array[row + 1][col]
    end
    if col < height_row.size - 1
      right = height_map_array[row][col + 1]
    end
    if e < left && e < right && e < top && e < bottom
      puts "#{e} is smaller than all its neighbours!"
      new_basin = calculate_basin(row, col, [], height_map_array)
      basins.push(new_basin.size)
      small_numbers.push(e)
    end
  end
end

puts "the sum of the risk levels is #{small_numbers.sum + small_numbers.size}"

puts "the basins are of size: #{basins.sort!.reverse!}"

puts "the product of the 3 largest basins is #{basins[0] * basins[1] * basins[2]}"
