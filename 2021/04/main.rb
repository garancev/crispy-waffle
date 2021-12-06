puts 'Welcome to day 4!'

def get_chosen_numbers(file_data)
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
    (0..5).each do |col|
      if bingo_cards[bingo_cards_count][col].size < 5
        bingo_cards[bingo_cards_count][col].push(number)
        break
      end
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

def print_winning_score(winning_card, number)
  puts "winner: #{number}"
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
    winning_card = bingo_cards.find do |bingo_card|
      winning_row = bingo_card.find do |bingo_row|
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

def process_until_last_winner(chosen_numbers, bingo_cards)
  chosen_numbers.each do |number|
    bingo_cards.each do |bingo_card|
      bingo_card.each do |bingo_row|
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

main_data = File.read("input.csv").split
chosen_numbers_1 = get_chosen_numbers(main_data)
bingo_cards_example_1 = build_bingo_cards(main_data)
process_until_first_winner(chosen_numbers_1, bingo_cards_example_1)

puts '~~~~ second part ~~~~'
main_data = File.read("input.csv").split
chosen_numbers_1 = get_chosen_numbers(main_data)
bingo_cards_example_1 = build_bingo_cards(main_data)
process_until_last_winner(chosen_numbers_1, bingo_cards_example_1)
