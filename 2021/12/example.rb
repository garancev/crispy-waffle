file_data_1 = File.readlines("example1.csv").map(&:chomp)

puts 'welcome to day 12!'

def next_stop(path)
  path.split('-').last
end

def path_starts_where_we_stopped(path, current_path)
  path.split('-').first == next_stop(current_path)
end

def path_wont_repeat_small_cave(path, current_path)
  go_to = next_stop(path)
  puts "go_to: #{go_to}"
  if go_to.size == 1 && go_to.match(/[a-z]+/) #is lower.case
    return !current_path.include?(go_to)
  end
  true
end

def add_next_stop(path)
  "-" + next_stop(path)
end

def path_is_ending(path)
  next_stop(path) == 'end'
end

def can_go_forward(path, current_path)
  path_starts_where_we_stopped(path, current_path) && path_wont_repeat_small_cave(path, current_path)
end

def explore(caves, current_path)
  branches = []
  no_progress = 0
  caves.each do |path|
    puts "path: #{path}"
    if can_go_forward(path, current_path)
      current_path += add_next_stop(path)
      # puts "building #{current_path}"
      if path_is_ending(current_path)
        puts "path ended! #{current_path}"
        branches.push(current_path)
        break
      end
      branches.push(explore(caves, current_path))
    else
      no_progress += 1
    end
  end
  if no_progress == caves.size && !path_is_ending(current_path)
    # puts "there was no progress #{current_path}"
    puts "there was no progress #{current_path}, we must go back."
    # todo: first check it won't repeat!
    cave_before_last = current_path.split('-')[current_path.split('-').size - 2]
    if !cave_before_last.match(/[a-z]+/) #only go back if is not lower case
      current_path += "-" + cave_before_last
      branches.push(explore(caves, current_path))
    end
  end
  # I reached the end of the map, but I didn't reach an exit, so I should look again!

  puts "branches: #{branches}"
  branches
end

def process(complete_map)
  possible_paths = []
  explored_paths = -1

  complete_map.each do |path|
    if path.split('-').first == 'start' #you're a path beginning
      explored_paths += 1
      result = explore(complete_map, path)
      puts result
    end
  end
end

process(file_data_1)
# puts "#{possible_paths}"