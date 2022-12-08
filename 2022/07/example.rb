file_data = File.readlines("example1.csv")

puts 'welcome to day 7!'
@index_reached = 1
def fill_directory(directory, dir_content, input)
  puts "directory: #{directory}"
  puts dir_content.inspect
  puts dir_content[:children].inspect
  last_dir_entered = directory
  input.each_with_index do |content, index|
    if index > @index_reached
      puts content
      split_content = content.split(' ')
      if content.start_with?('dir')
        puts 'dir child'
        @index_reached = index
        # dir_content[:children].push({type: 'dir', size: 0, name: split_content[1]})
        #is a directory, we have to loop
      elsif content.start_with?('$ ')
        @index_reached = index
        # is instruction
        if split_content[1] == 'cd'
          puts 'is cd'
          if split_content[2] == '..'
            break
            # stop the loop, go back up one level
          else
            last_dir_entered = split_content[2]
            dir_content[:children].push({ name: last_dir_entered, type: 'dir', size: 0, children: []}) #if dir_content[:children][last_dir_entered].nil?
          end
        elsif split_content[1] = 'ls'
          puts 'is ls'
          the_dir_to_fill = dir_content[:children].select{|children| children[:name] == last_dir_entered}.first
          puts the_dir_to_fill.inspect
          @index_reached = index
          fill_directory(last_dir_entered, the_dir_to_fill, input)
        end
      else
        dir_content[:children].push({type: 'file', size: split_content[0], name: split_content[1]})
        @index_reached = index
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
      directory[:size] = directory[:size] + child[:size].to_i
    end
  end
  directory[:size]

  # directory.each do |file|
  #   puts file.inspect
  #   # if file.type =
  # end
end
#To begin, find all of the directories with a total size of at most 100000,
# then calculate the sum of their total sizes.
# In the example above, these directories are a and e;
# the sum of their total sizes is 95437 (94853 + 584).
# (As in this example, this process can count files more than once!)
# def filter_by_size(directory)
#   if directory[:size] <= 100000
#   directory.select do |child|
#     if child[:type] == 'dir'
#       child[:size] <= 100000
#     else
#       false
#     end
#   end
# end
def find_directories_under_100000(dir_under_100000, dir)
  dir[:children].each do |child|
    puts 'child'
    # puts child.inspect
    if child[:type] == 'dir'
      puts "#{child[:name]} is a dir"
      if child[:size] <= 100000
        puts "#{child[:name]} is under 100000"
        dir_under_100000.push(child)
      end
      find_directories_under_100000(dir_under_100000, child)
    end
  end
  puts '~~~'
  # puts dir_under_100000.inspect
  dir_under_100000
end

def find_directories_above_x(x, dir_above_x, dir)
  dir[:children].each do |child|
    puts 'child'
    # puts child.inspect
    if child[:type] == 'dir'
      puts "#{child[:name]} is a dir"
      if child[:size] > x
        puts "#{child[:name]} is above #{x}"
        dir_above_x.push(child)
      end
      find_directories_above_x(x, dir_above_x, child)
    end
  end
  puts '~~~'
  # puts dir_under_100000.inspect
  dir_above_x
end

def sum_of_big_directories
  sum_directories_size(@file_system)
  dirs_under_100000 = find_directories_under_100000([], @file_system)
  dirs_under_100000.sum {|dir| dir[:size] }
  # find_directories_over_100000.reduce(0) {|sum, directory| sum + directory.size }
end

def find_smallest_deletion_candidate
  size_needed = 70000000 - @file_system[:size]
  puts "I need #{size_needed}"
  candidates = find_directories_above_x(size_needed, [], @file_system)
  if candidates.empty?
    return @file_system[:size]
  else
    return candidates.min {|dir| dir[:size] }[:size]
  end
end

puts 'What is the sum of the total sizes of those directories?'
puts sum_of_big_directories

puts "~~~ and what is the size of the smallest directory I can delete? ~~~"
puts find_smallest_deletion_candidate

