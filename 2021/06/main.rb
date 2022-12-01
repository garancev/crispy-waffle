file_data = File.read("input.csv").split(',').map(&:chomp).map(&:to_i)

puts 'welcome to day 6!'

total = file_data.size
school = file_data.clone
puts "we start with #{total} lanternfish"

def reduce_one_day(array, current_counter)
  if current_counter == 0
    array.push(8)
    new_counter =  6
  elsif current_counter <= 8
    new_counter = current_counter - 1
  end
  array.push(new_counter)
  array
end

for day in 1..80
  new_school = school.reduce([]) { |memo, fish_counter| reduce_one_day(memo, fish_counter) }
  school = new_school
end
puts "after 80 days there are #{school.size} lanternfish"

data_again = File.read("input.csv").split(',').map(&:chomp).map(&:to_i)

# set up the starting school
lanternfish_school = Array.new(9, 0)
for age in 0..8
  lanternfish_school[age] = data_again.count(age)
end

for day in 1..256
  ready_to_spawn = lanternfish_school.shift
  lanternfish_school[8] = ready_to_spawn
  lanternfish_school[6] += ready_to_spawn
end
puts "after 256 days there are #{lanternfish_school.sum} lanternfish"
