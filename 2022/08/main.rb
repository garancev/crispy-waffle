require 'csv'
file_data = CSV.read("input.csv")

puts 'welcome to day 8!'

def count_scenic_score(trees_patch, col_count, line_count)
  trees_patch.map.each_with_index do |line, line_no|
    line.map.each_with_index do |tree, col_no|
      score = {top: 0, left: 0, right: 0, down: 0}
      top = line_no - 1
      while top >= 0 do
        score[:top] += 1
        top = trees_patch[top][col_no] < tree ? top - 1 : -1
      end
      left = col_no - 1
      while left >= 0 do
        score[:left] += 1
        left = line[left] < tree ? left - 1 : -1
      end
      right = col_no + 1
      while right <= col_count do
        score[:right] += 1
        right = line[right] < tree ? right + 1 : col_count + 1
      end
      bottom = line_no + 1
      while bottom <= line_count do
        score[:down] += 1
        bottom = trees_patch[bottom][col_no] < tree ? bottom + 1 : line_count + 1
      end
      score.values.inject(:*)
    end
  end.flatten.max
end

def is_at_edge(line_no, col_no, lines_count, col_count)
  line_no == 0 || col_no == 0 || line_no == lines_count || col_no == col_count
end

def visible_from_left(col_no, tree, line)
  left = col_no - 1
  while left >= 0 && line[left] < tree do
    left -= 1
  end
  left == -1
end
def visible_from_right(col_no, tree, line, col_count)
  right = col_no + 1
  while right <= col_count && line[right] < tree do
    right += 1
  end
  right == col_count + 1 #I could reach the edge only with smaller trees
end

def visible_from_top(line_no, tree, trees_patch, col_no)
  top = line_no - 1
  while top >= 0 && trees_patch[top][col_no] < tree do
    top -= 1
  end
  top == -1
end

def visible_from_bottom(line_no, tree, trees_patch, lines_count, col_no)
  bottom = line_no + 1
  while bottom <= lines_count && trees_patch[bottom][col_no] < tree do
    bottom += 1
  end
  bottom == lines_count + 1
end
def count_visible_trees(trees_patch, col_count, lines_count)
  visible_trees = 0
  trees_patch.each_with_index do |line, line_no|
    line.each_with_index do |tree, col_no|
      if is_at_edge(line_no, col_no, lines_count, col_count)
        visible_trees += 1
      else
        if visible_from_left(col_no, tree, line)
          visible_trees += 1
        elsif visible_from_right(col_no, tree, line, col_count)
          visible_trees += 1
        elsif visible_from_top(line_no, tree, trees_patch, col_no)
          visible_trees += 1
        elsif visible_from_bottom(line_no, tree, trees_patch, lines_count, col_no)
          visible_trees += 1
        end
      end
    end
  end
  visible_trees
end

file_data.map! {|line| line[0].split(//)}
col_count = file_data[0].size - 1
lines_count = file_data.size - 1
puts 'What is the number of visible trees?'
puts count_visible_trees(file_data, col_count, lines_count)

puts "~~~ and what is the highest scenic score possible for any tree? ~~~"
puts count_scenic_score(file_data, col_count, lines_count)
