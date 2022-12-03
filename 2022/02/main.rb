require 'csv'
col_sep = ' '
file_data = CSV.read("input.csv", col_sep: col_sep)

puts 'welcome to day 2!'

@left_key = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors'
}

# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"

@right_key = {
  'X' => 'rock',
  'Y' => 'paper',
  'Z' => 'scissors'
}

@points = {
  'rock' => 1,
  'paper' => 2,
  'scissors' => 3
}

@win = 6
@draw = 3
@lose = 0

@correct_right_key = {
  'X' => @lose,
  'Y' => @draw,
  'Z' => @win
}

def do_i_win?(hand)
  opponent = @left_key[hand[0]]
  me =  @right_key[hand[1]]
  return @draw if opponent == me
  return @lose if opponent == 'rock' && me == 'scissors'
  return @lose if opponent == 'scissors' && me == 'paper'
  return @lose if opponent == 'paper' && me == 'rock'
  @win
end

def points_for_game(hand)
  @correct_right_key[hand[1]]
end
def my_hand?(hand)
  opponent = @left_key[hand[0]]
  if points_for_game(hand) == @win
    return @points['paper'] if opponent == 'rock'
    return @points['rock'] if opponent == 'scissors'
    return @points['scissors'] if opponent == 'paper'
  elsif points_for_game(hand) == @lose
    return @points['scissors'] if opponent == 'rock'
    return @points['paper'] if opponent == 'scissors'
    return @points['rock'] if opponent == 'paper'
  end
  return @points[opponent]
end

def points_for_hand(hand)
  me = @right_key[hand[1]]
  @points[me]
end

def sum_all_points(strategy)
  strategy.reduce(0) do |points, hand|
    points + do_i_win?(hand) + points_for_hand(hand)
  end
end

def sum_points_correctly(strategy)
  strategy.reduce(0) do |points, hand|
    points + points_for_game(hand) + my_hand?(hand)
  end
end

puts "total points: #{sum_all_points(file_data)}"

puts 'how many points do I have at the end?'

puts sum_all_points(file_data)

puts '~~~ And how many points do I really have? ~~~'
puts sum_points_correctly(file_data)
