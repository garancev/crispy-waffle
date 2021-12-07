file_data = File.read("example1.csv").split(',').map(&:chomp).map(&:to_i)

puts 'welcome to day 6!'

total = file_data.size
school = file_data.clone
puts "we start with #{total} lanternfish"

for day in 1..80
  ready_to_spawn = school.count { |x| x == 0 }
  school.map! do |fish_counter|
    new_counter = fish_counter - 1
    if fish_counter == 0
      new_counter = 6
    end
    new_counter
  end
  if ready_to_spawn.positive?
    for x in 1..ready_to_spawn
      school.push(8)
    end
  end
end
puts "after 80 days there are #{school.size} lanternfish"


puts '~~~ Part 2 ~~~'

clean_data = File.read("example1.csv").split(',').map(&:chomp).map(&:to_i)

# set up the starting school
lanternfish_school = Array.new(9, 0)
for age in 0..8
  lanternfish_school[age] = clean_data.count(age)
end
puts "#{lanternfish_school}"

for day in 1..256
  # puts "day #{day}, #{lanternfish_school}"
  ready_to_spawn = lanternfish_school.shift
  # puts "there are #{ready_to_spawn} fish at 0"
  lanternfish_school[8] = ready_to_spawn
  lanternfish_school[6] += ready_to_spawn
end
puts "after 256 days there are #{lanternfish_school.sum} lanternfish"
