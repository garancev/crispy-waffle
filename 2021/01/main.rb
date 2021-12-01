file_data = File.read("input.csv").split.map(&:to_i)

puts 'welcome to day 1!'

def find_increments(data)
  increments = 0
  data.each_cons(2) do |depth|
    if depth[1] - depth[0] > 0
      increments = increments + 1
    end
  end
  increments
end

puts 'how many increments?'
puts find_increments(file_data)

puts '~~~~ sliding increments ~~~~'

measurement_windows = []
measurement_windows = file_data.each_cons(3).map(&:sum)
puts find_increments(measurement_windows)
