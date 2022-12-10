require 'csv'
file_data_1 = CSV.read("example1.csv", col_sep: ' ')
file_data_2 = CSV.read("example2.csv", col_sep: ' ')

puts 'welcome to day 10!'

def go_right(motion)
  motion[0] == 'R'
end
def go_left(motion)
  motion[0] == 'L'
end
def go_up(motion)
  motion[0] == 'U'
end
def go_down(motion)
  motion[0] == 'D'
end

def move_head(head_current, motion)
  return [head_current[0] + 1, head_current[1]] if go_right(motion)
  return [head_current[0] - 1, head_current[1]] if go_left(motion)
  return [head_current[0], head_current[1] + 1] if go_up(motion)
  return [head_current[0], head_current[1] - 1] if go_down(motion)
  return head_current
end
def same_column(tail, head)
  head[0] == tail[0]
end
def same_row(tail, head)
  head[1] == tail[1]
end
def is_left(tail, head)
  tail[0] - head[0] >= 2
end
def is_right(tail, head)
  head[0] - tail[0] >= 2
end
def is_up(tail, head)
  head[1] - tail[1] >= 2
end
def is_down(tail, head)
  tail[1] - head[1] >= 2
end

def head_is_2_up(tail, head)
  is_up(tail, head) && same_column(tail, head)
end
def head_is_2_right(tail, head)
  is_right(tail, head) && same_row(tail, head)
end
def head_is_2_down(tail, head)
  is_down(tail, head)  && same_column(tail, head)
end
def head_is_2_left(tail, head)
  is_left(tail, head) && same_row(tail, head)
end
def head_is_up_right(tail,  head)
  is_up(tail, head) && head[0] - tail[0] >= 1 || is_right(tail, head) && head[1] - tail[1] >= 1
end
def head_is_up_left(tail,  head)
  is_up(tail, head) && tail[0] - head[0] >= 1 || is_left(tail, head) && head[1] - tail[1] >= 1
end
def head_is_down_right(tail,  head)
  is_down(tail, head) && head[0] - tail[0] >= 1 || is_right(tail, head) && tail[1] - head[1] >= 1
end
def head_is_down_left(tail,  head)
  is_down(tail, head) && tail[0] - head[0] >= 1 || is_left(tail, head) && tail[1] - head[1] >= 1
end

def move_tail(tail_current, head_current)
  if head_is_2_up(tail_current, head_current)
    return [tail_current[0], tail_current[1] + 1]
  end
  if head_is_2_right(tail_current, head_current)
    return [tail_current[0] + 1, tail_current[1]]
  end
  if head_is_2_left(tail_current, head_current)
    return [tail_current[0] - 1, tail_current[1]]
  end
  if head_is_2_down(tail_current, head_current)
    return [tail_current[0], tail_current[1] - 1]
  end
  if head_is_up_right(tail_current, head_current)
    return [tail_current[0] + 1, tail_current[1] + 1]
  end
  if head_is_up_left(tail_current, head_current)
    return [tail_current[0] - 1, tail_current[1] + 1]
  end
  if head_is_down_right(tail_current, head_current)
    return [tail_current[0] + 1, tail_current[1] - 1]
  end
  if head_is_down_left(tail_current, head_current)
    return [tail_current[0] - 1, tail_current[1] - 1]
  end
  return tail_current
end

def visualise_progress(head, tails)
  # print "  "
  # (0..20).each do |col_no|
  #   print "#{col_no} "
  # end
  puts
  (0..20).reverse_each do |row_no|
    # print "#{row_no} "
    (0..25).each do |col_no|
      if col_no == head[0] && row_no == head[1]
        print 'H '
      else
        knot_here = 0
        tails.each_with_index do |tail, index|
          if col_no == tail[:positions].last[0] && row_no == tail[:positions].last[1]
            knot_here = index + 1
            break
          end
        end
        if knot_here > 0
          print "#{knot_here} "
        else
        print ". "
        end
      end
    end
    puts  # end the line
  end
end

def visualise_visited(tail)
  print "  "
  (0..5).each do |col_no|
    print "#{col_no} "
  end
  puts
  (0..5).reverse_each do |row_no|
    print "#{row_no} "
    (0..5).each do |col_no|
      visited = false
      tail.each_with_index do |pos, index|
        if col_no == pos[0] && row_no == pos[1]
          visited = true
        end
      end
      if visited
        print "# "
      else
      print ". "
      end
    end
    puts  # end the line
  end
end

def count_visited_positions(motions, head, tails)
  visualise_progress(head[:positions].last, tails)
  motions.each_with_index do |motion, index|
    times = motion[1].to_i
    log = motion == ["U", "8"]

    puts "== #{motion[0]} #{motion[1]} =="
    while times > 0 do
      visualise_progress(head[:positions].last, tails) if log
      head[:positions] << move_head(head[:positions].last, motion)
      tails.each_with_index do |tail, index|
        previous = index == 0 ? head : tails[index - 1]
        tail[:positions] << move_tail(tail[:positions].last, previous[:positions].last)
      end
      times -= 1
    end
  end
  visualise_visited(tails.last[:positions].uniq)
  tails.last[:positions].uniq.size
end

def count_visited_positions_2_knots(motions)
  head = {positions: Array.new(1) { Array.new(2,0) }}
  tail = {positions: Array.new(1) { Array.new(2,0) }}
  count_visited_positions(motions, head, [tail])
end
def count_visited_positions_10_knots(motions)
  head = {positions: Array.new(1) { Array.new(2,0) }}
  puts head.inspect
  # head[:positions] = [[11, 5]]
  puts head.inspect
  tails = Array.new(9, Hash.new)
  tails.map! {|hash| {positions: [[0, 0]]} }
  count_visited_positions(motions, head, tails)
end
def count_visited_positions_10_knots_different_start(motions)
  head = {positions: Array.new(1) { Array.new(2,0) }}
  head[:positions] = [[11, 5]]
  tails = Array.new(9, Hash.new)
  tails.map! {|hash| {positions: [[11, 5]]} }
  count_visited_positions(motions, head, tails)
end
puts 'How many positions does the tail of the rope visit at least once?'
# puts count_visited_positions_2_knots(file_data_1)

puts "~~~ and how many positions does the tail of the rope visit at least once? ~~~"
# puts count_visited_positions_10_knots(file_data_1)
puts "~~~ and with the larger example? ~~~"
puts count_visited_positions_10_knots_different_start(file_data_2)