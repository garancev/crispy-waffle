file_data_1 = File.readlines("example1.csv").map(&:chomp)
file_data_2 = File.readlines("example2.csv").map(&:chomp)

puts 'welcome to day 10!'

@syntax_error_score = 0
@characters = {
  '[' => ']',
  '{' => '}',
  '(' => ')',
  '<' => '>'
}

@points = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
  nil => 0
}

@completion_points = {
  # '(' => 1,
  ')' => 1,
  # '[' => 2,
  ']' => 2,
  # '{' => 3,
  '}' => 3,
  # '<' => 4,
  '>' => 4
}

def starting_chunk?(character)
  return @characters.keys.include?(character)
end
def ending_chunk?(character)
  return @characters.values.include?(character)
end

def find_corruption(chunk)
  start_pile = []
  chunk.split(//).each_with_index do |symbol, index|
    if starting_chunk?(symbol)
      start_pile.push(symbol)
    elsif ending_chunk?(symbol)
      if @characters.key(symbol) == start_pile.last
        start_pile.pop
      else
        return symbol
      end
    end
  end
  return
end

def calculate_autocomplete(chunk)
  start_pile = []
  chunk.split(//).each_with_index do |symbol, index|
    if starting_chunk?(symbol)
      start_pile.push(symbol)
    elsif ending_chunk?(symbol)
      if @characters.key(symbol) == start_pile.last
        start_pile.pop
      end
    end
  end

  autocomplete_pile = start_pile.map { |character| @characters[character]}.reverse
  return autocomplete_pile.inject(0) do |memo, character|
    memo * 5 + @completion_points[character]
  end
end

def process(file_data)
  syntax_error_score = file_data.inject(0) { |memo, line| memo + @points[find_corruption(line)] }
  only_incomplete = file_data.filter { |line| find_corruption(line).nil? }
  puts "#{only_incomplete}"
  auto_complete_scores = only_incomplete.map { |line| calculate_autocomplete(line) }
  puts "autocomplete score: #{auto_complete_scores.sort[auto_complete_scores.size/2.floor]}"
  # median_index = n/2.floor
  # median = file_data[median_index]
  puts "total syntax error score: #{syntax_error_score}"
  # puts "total autocomplete score: #{auto_complete_scores}"
end

process(file_data_1)
process(file_data_2)

