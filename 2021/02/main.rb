file_data = File.readlines("input.csv")

puts 'welcome to day 2!'
depth = 0
horizontal = 0
aim = 0
file_data.each do |direction|
  move = direction.split
  case move.first
  when 'forward'
    horizontal += move.last.to_i
    depth += aim * move.last.to_i
  when 'down'
    aim += move.last.to_i
  when 'up'
    aim -= move.last.to_i
  end
end

puts 'where are we going?'
puts depth * horizontal