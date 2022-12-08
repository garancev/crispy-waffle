require 'csv'
file_data = CSV.read("example1.csv")

puts 'welcome to day 8!'

def count_scenic_score(trees_patch, col_count, lines_count)
  scenic_scores_matrix = trees_patch.map.each_with_index do |line, line_no|
    puts '~~~~~~~'
    puts "line #{line}, #{line_no}"
      line.map.each_with_index do |tree, col_no|
        top_score = 0
        left_score = 0
        right_score = 0
        bottom_score = 0
      if line_no > 0
        previous_line = line_no - 1
        top = previous_line
        while top >= 0 do #&& trees_patch[top][col_no] <= tree do
          top_score +=  1
          if trees_patch[top][col_no] < tree
            top -= 1
          else
            top = -1
          end
        end
      end
      if col_no > 0
        previous_col = col_no - 1
        left = previous_col
        while left >= 0 do #&& line[left] <= tree do
          left_score += 1
          if line[left] < tree
            left -= 1
          else
            left = -1
          end
        end
      end
      if col_no < col_count
        next_col = col_no + 1
        right = next_col
        while right <= col_count do #&& line[right] <= tree do
          right_score += 1
          if line[right] < tree
            right += 1
          else
            right = col_count + 1
          end
        end
      end
      if line_no < lines_count
        next_line = line_no + 1
        bottom = next_line
        while bottom <= lines_count do #&& trees_patch[bottom][col_no] <= tree do
          bottom_score += 1
          if trees_patch[bottom][col_no] < tree
            bottom += 1
          else
            bottom = lines_count + 1
          end
        end
      end
      puts "Tree #{tree}[#{line_no + 1}, #{col_no + 1}] has a score of #{top_score}*#{left_score}*#{right_score}*#{bottom_score}"
      left_score * right_score * top_score * bottom_score
    end
  end
  puts scenic_scores_matrix.inspect
  scenic_scores_matrix.flatten.max
end


def count_visible_trees(trees_patch, col_count, lines_count)
  visible_trees = 0
  trees_patch.each_with_index do |line, line_no|
    line.each_with_index do |tree, col_no|
      if line_no == 0 || col_no == 0 || line_no == lines_count || col_no == col_count
        visible_trees = visible_trees + 1
      else
        left = col_no - 1
        while left >= 0 && line[left] < tree do
          left = left - 1
        end
        if left == -1 #I could reach the edge only with smaller trees
          visible_trees = visible_trees + 1
        else #not visible from left, let's look at rigth
          right = col_no + 1
          while right <= col_count && line[right] < tree do
            right = right + 1
          end
          if right == col_count + 1 #I could reach the edge only with smaller trees
            visible_trees = visible_trees + 1
          else # not visible from right, let's check top
            top = line_no - 1
            while top >= 0 && trees_patch[top][col_no] < tree do
              top = top - 1
            end
            if top == -1 #I could reach the edge only with smaller trees
              visible_trees = visible_trees + 1
            else #not visible from top, let's look at bottom
              bottom = line_no + 1
              while bottom <= lines_count && trees_patch[bottom][col_no] < tree do
                bottom = bottom + 1
              end
              if bottom == lines_count + 1 #I could reach the edge only with smaller trees
                visible_trees = visible_trees + 1
              end
            end
          end
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
