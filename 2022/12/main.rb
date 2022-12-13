require 'csv'
file_data_1 = File.readlines("input.csv").map(&:chomp)

puts 'welcome to day 12!'
@distances = [*'a'..'z']

def create_unvisited_set(heightmap, starting_points)
  unvisited_set = []
  heightmap.each_with_index do |row, row_index|
    row.each_with_index do |location, col_index|
      unvisited = {
        pos:  [row_index, col_index],
        height: location,
        tentative_distance: starting_points.include?(location) ? 0 : 100_000_000
      }
      unvisited_set << unvisited
    end
  end
  unvisited_set
end

def is_accessible_in_1(target, current)
  current_height = @distances.index(current[:height])
  target_height = @distances.index(target[:height])
  if current[:height] == 'S'
    current_height = @distances.index('a')
  elsif current[:height] == 'E'
    current_height = @distances.index('z')
  end
  if target[:height] == 'S'
    target_height = @distances.index('a')
  elsif target[:height] == 'E'
    target_height = @distances.index('z')
  end
  target_height - current_height <= 1
end
def new_distance(heightmap, location, neighbour)
  if is_accessible_in_1(neighbour, location)
    new_tentative_distance = location[:tentative_distance] + 1
    return new_tentative_distance if neighbour[:tentative_distance] < 0 || new_tentative_distance < neighbour[:tentative_distance]
  end
  return neighbour[:tentative_distance]
end

# as described on https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
def find_path_with_dijkstra(heightmap, starting_points)
  unvisited_set = create_unvisited_set(heightmap, starting_points)

  found_e = nil
  while found_e.nil? do
    to_visit = unvisited_set.min {|a, b| a[:tentative_distance] <=> b[:tentative_distance] }
    found_e = to_visit if to_visit[:height] == 'E'
    row_index = to_visit[:pos][0]
    col_index = to_visit[:pos][1]
    right_node = unvisited_set.index{|node| node[:pos] == [row_index, col_index + 1]}
    left_node = unvisited_set.index{|node| node[:pos] == [row_index, col_index - 1]}
    top_node = unvisited_set.index{|node| node[:pos] == [row_index - 1, col_index]}
    down_node = unvisited_set.index{|node| node[:pos] == [row_index + 1, col_index]}
    if !right_node.nil?
      unvisited_set[right_node][:tentative_distance] = new_distance(unvisited_set, to_visit, unvisited_set[right_node])
    end
    if !left_node.nil?
      unvisited_set[left_node][:tentative_distance] = new_distance(unvisited_set, to_visit, unvisited_set[left_node])
    end
    if !top_node.nil?
      unvisited_set[top_node][:tentative_distance] = new_distance(unvisited_set, to_visit, unvisited_set[top_node])
    end
    if !down_node.nil?
      unvisited_set[down_node][:tentative_distance] = new_distance(unvisited_set, to_visit, unvisited_set[down_node])
    end
    unvisited_set.delete(to_visit)
  end
  return found_e
end


def calculate_path(raw_heightmap, starting_points)
  heightmap = raw_heightmap.map {|row| row.split(//)}
  path = find_path_with_dijkstra(heightmap, starting_points)
  puts path.inspect
end

puts 'What is the fewest steps required to move from your current position to the location that should get the best signal?'
calculate_path(file_data_1, ['S'])

puts "~~~ and What is the fewest steps required to move starting from any square with elevation a to the location that should get the best signal? ~~~"
calculate_path(file_data_1, ['S', 'a'])