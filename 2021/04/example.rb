puts 'welcome to day 4!'

def chosen_numbers(file_data)
  file_data.slice!(0).split(',')
end
def build_bingo_cards(file_data)
  bingo_cards = Array.new
  bingo_cards_count = -1
  file_data.each_with_index do |number, index|
    if index % 25 == 0
      bingo_cards_count += 1
      bingo_cards.push([])
      5.times do
        bingo_cards[bingo_cards_count].push([])
      end
    end
    if bingo_cards[bingo_cards_count][0].size < 5
      bingo_cards[bingo_cards_count][0].push(number)
    elsif bingo_cards[bingo_cards_count][1].size < 5
      bingo_cards[bingo_cards_count][1].push(number)
    elsif bingo_cards[bingo_cards_count][2].size < 5
      bingo_cards[bingo_cards_count][2].push(number)
    elsif bingo_cards[bingo_cards_count][3].size < 5
      bingo_cards[bingo_cards_count][3].push(number)
    elsif bingo_cards[bingo_cards_count][4].size < 5
      bingo_cards[bingo_cards_count][4].push(number)
    end
  end
  bingo_cards
end

def is_marked?(number)
  number.start_with?('#')
end

def mark_number_on_row!(bingo_row, number)
  bingo_row.map! do |bingo_number|
    result = bingo_number
    if number == bingo_number
      result = "##{bingo_number}"
    end
    result
  end
end

def mark_on_row(bingo_row, number)
  bingo_row.map do |bingo_number|
    puts "Looking at row #{bingo_row.join}"
    result = bingo_number
    if number == bingo_number
      result = "##{bingo_number}"
    end
    result
  end
end
def mark_numbers_on_card(bingo_card, number)
  bingo_card.map! do |bingo_row|
    mark_on_row(bingo_row, number)
  end
end

def find_first_winning_card(bingo_card, number)
  winning_row = bingo_card.find do |bingo_row|
    bingo_row = mark_on_row(bingo_row, number)
    bingo_row.all? { |bingo_number| is_marked?(bingo_number) }
  end
  if winning_row.nil?
    winning_col = bingo_card.transpose.find do |bingo_col|
      bingo_col.all? { |bingo_number| is_marked?(bingo_number) }
    end
  end
  !winning_row.nil? || !winning_col.nil?
end

def print_winning_score(winning_card, number)
  puts "winner: #{number}"
  puts winning_card
  sum = 0
  winning_card.each do |row|
    row.delete_if { |bingo_number| is_marked?(bingo_number) }
    sum += row.map(&:to_i).sum
  end
  puts "final score: #{sum * number.to_i}"
end

def is_selection_winner?(selection)
  selection.all? { |bingo_number| is_marked?(bingo_number) }
end

def process_until_first_winner(chosen_numbers, bingo_cards)
  chosen_numbers.each do |number|
    puts "Now playing #{number}"
    winning_card = bingo_cards.find do |bingo_card|
      winning_row = bingo_card.find do |bingo_row|
        puts "Looking at row #{bingo_row.join}"
        mark_number_on_row!(bingo_row, number)
        is_selection_winner?(bingo_row)
      end
      if winning_row.nil?
        winning_col = bingo_card.transpose.find do |bingo_col|
          is_selection_winner?(bingo_col)
        end
      end
      !winning_row.nil? || !winning_col.nil?
    end
    if !winning_card.nil?
      print_winning_score(winning_card, number)
      break
    end
  end
end

file_1_data = File.read("example1.csv").split
chosen_numbers_1 = chosen_numbers(file_1_data)
bingo_cards_example_1 = build_bingo_cards(file_1_data)
process_until_first_winner(chosen_numbers_1, bingo_cards_example_1)

# file_2_data = File.read("example2.csv").split
# chosen_numbers_2 = chosen_numbers(file_2_data)
# bingo_cards_example_2 = build_bingo_cards(file_2_data)
# process(chosen_numbers_2, bingo_cards_example_2)
# Except 843 * 7 = 5901 for first part

puts '~~~~ second part ~~~~'

def process_until_last_winner(chosen_numbers, bingo_cards)
  chosen_numbers.each do |number|
    puts "Now playing #{number}"
    bingo_cards.each do |bingo_card|
      bingo_card.each do |bingo_row|
        puts "Looking at row #{bingo_row.join}"
        mark_number_on_row!(bingo_row, number)
      end
    end
    winning_cards = bingo_cards.find_all do |bingo_card|
      winning_row = bingo_card.find do |bingo_row|
        is_selection_winner?(bingo_row)
      end
      if winning_row.nil?
        winning_col = bingo_card.transpose.find do |bingo_col|
          is_selection_winner?(bingo_col)
        end
      end
      !winning_row.nil? || !winning_col.nil?
    end
    if bingo_cards.size > 1
      bingo_cards = bingo_cards - winning_cards
    elsif winning_cards.size > 0
      print_winning_score(winning_cards.first, number)
      break
    end
  end
end

file_1_data = File.read("example1.csv").split
chosen_numbers_1 = chosen_numbers(file_1_data)
bingo_cards_example_1 = build_bingo_cards(file_1_data)
process_until_last_winner(chosen_numbers_1, bingo_cards_example_1)

# In the above example, the second board is the last to win,
# which happens after 13 is eventually called and its middle column is completely marked.
# If you were to keep playing until this point, the second board would have
# a sum of unmarked numbers equal to 148 for a final score of 148 * 13 = 1924.