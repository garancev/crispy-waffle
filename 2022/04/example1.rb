require 'csv'
col_sep = ','
file_data = CSV.read("example1.csv", col_sep: col_sep)

puts 'welcome to day 4!'
def numerical_assignment(assignment)
  assignment.split('-').map{|nb| nb.to_i}
end

def overlap_at_start(assigment_1, assignment_2)
  (assigment_1[0]..assigment_1[1]) === assignment_2[0]
end

def overlap_at_end(assigment_1, assignment_2)
  (assigment_1[0]..assigment_1[1]) === assignment_2[1]
end


def count_contained_pairs(pairs)
  contained_pairs = 0
  pairs.each do |pair|
    first = numerical_assignment(pair[0])
    second = numerical_assignment(pair[1])
    #pair 2 is included in pair 1
    if (overlap_at_start(first, second) && overlap_at_end(first, second))
      contained_pairs = contained_pairs + 1
    elsif (overlap_at_start(second, first) && overlap_at_end(second, first))
      contained_pairs = contained_pairs + 1
    end
  end
  contained_pairs
end

def count_overlapping_pairs(pairs)
  overlapping_pairs = 0
  pairs.each do |pair|
    first = numerical_assignment(pair[0])
    second = numerical_assignment(pair[1])
    #pair 2 is included in pair 1
    if (overlap_at_start(first, second) || overlap_at_end(first, second) || overlap_at_start(second, first) || overlap_at_end(second, first))
      overlapping_pairs = overlapping_pairs + 1
    end
  end
  overlapping_pairs
end

puts 'how many pairs have pointless assignments?'
puts count_contained_pairs(file_data)

puts "~~~ and how many pairs are overlapping? ~~~"

puts count_overlapping_pairs(file_data)

