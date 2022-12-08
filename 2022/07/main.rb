file_data = File.readlines("input.csv")

puts 'welcome to day 7!'
@index_reached = 1
def fill_directory(directory, dir_content, input)
  last_dir_entered = directory
  input.each_with_index do |content, index|
    if index > @index_reached
      @index_reached = index
      split_content = content.split(' ')
      if content.start_with?('dir')
      elsif content.start_with?('$ ')
        if split_content[1] == 'cd'
          if split_content[2] == '..'
            break
            # stop the loop, go back up one level
          else
            last_dir_entered = split_content[2]
            dir_content[:children].push({ name: last_dir_entered, type: 'dir', size: 0, children: []}) #if dir_content[:children][last_dir_entered].nil?
          end
        elsif split_content[1] = 'ls'
          the_dir_to_fill = dir_content[:children].select{|children| children[:name] == last_dir_entered}.first
          fill_directory(last_dir_entered, the_dir_to_fill, input)
        end
      else
        dir_content[:children].push({type: 'file', size: split_content[0].to_i, name: split_content[1]})
      end
    end
  end
  dir_content
end

def build_file_system(data)
  fill_directory('/', { name: '/', type: 'dir', size: 0, children: [] }, data)
end

@file_system = build_file_system(file_data)

def sum_directories_size(directory)
  directory[:children].each do |child|
    if child[:type] == 'dir'
      directory[:size] = directory[:size] + sum_directories_size(child)
    else
      puts child[:name]
      directory[:size] = directory[:size] + child[:size]
    end
  end
  directory[:size]
end

def find_directories_under_100000(dir_under_100000, dir)
  dir[:children].each do |child|
    if child[:type] == 'dir'
      if child[:size] <= 100000
        dir_under_100000.push(child)
      end
      find_directories_under_100000(dir_under_100000, child)
    end
  end
  dir_under_100000
end

def find_directories_above_x(x, dir_above_x, dir)
  dir[:children].each do |child|
    if child[:type] == 'dir'
      if child[:size] >= x
        dir_above_x.push(child)
      end
      find_directories_above_x(x, dir_above_x, child)
    end
  end
  dir_above_x
end

def sum_of_big_directories
  sum_directories_size(@file_system)
  dirs_under_100000 = find_directories_under_100000([], @file_system)
  dirs_under_100000.sum {|dir| dir[:size] }
end

def find_smallest_deletion_candidate
  needed = 30000000
  remaining_space = 70000000 - @file_system[:size]
  space_needed = needed - remaining_space
  puts "file_system_size = #{@file_system[:size]}"
  puts "remaining space = #{@remaining_space}"
  puts "I need #{space_needed} "
  candidates = find_directories_above_x(space_needed, [], @file_system)
  sizes_only = candidates.map {|dir| dir[:size]}
  sizes_only.min
end

puts 'What is the sum of the total sizes of those directories?'
puts sum_of_big_directories

puts "~~~ and what is the size of the smallest directory I can delete? ~~~"
puts find_smallest_deletion_candidate

