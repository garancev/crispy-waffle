file_data = File.readlines("example2.csv").map(&:chomp)

puts 'welcome to day 8!'

codes = file_data.map { |line| line.split(' | ')[1] }

first_sum = 0
codes.each do |numbers|
  interesting_numbers = numbers.split(' ').select do |number|
    number.length == 2 || number.length == 3 || number.length == 4 || number.length == 7
  end
  first_sum += interesting_numbers.size
end

puts first_sum

puts '~~~part 2 ~~~'

def letters_for_1(separate_numbers)
  separate_numbers.filter { |number| number.length == 2 }.first.split(//)
end

def letters_for_4(separate_numbers)
  separate_numbers.filter { |number| number.length == 4 }.first.split(//)
end

sum = 0

file_data.each do |complete_line|
  codes = complete_line.split(' | ')
  bar_to_letter = {}

  all_letters = codes[0].gsub(/\s+/, "").split(//).tally
  separate_numbers = codes[0].split(' ')
  bar_to_letter['bottom_right'] = all_letters.max_by{|k,v| v}[0]
  bar_to_letter['top_right'] = (letters_for_1(separate_numbers) - [bar_to_letter['bottom_right']]).first
  bar_to_letter['bottom_left'] = all_letters.min_by{|k,v| v}[0]
  bar_to_letter['top'] = all_letters.select{ |k, v| v == 8 && k != bar_to_letter['top_right'] }.keys[0]
  bar_to_letter['top_left'] = all_letters.select{ |k, v| v == 6 }.keys[0]
  bar_to_letter['middle'] = all_letters.select{ |k, v| v == 7 && letters_for_4(separate_numbers).include?(k)}.keys[0] # both at 7
  bar_to_letter['bottom'] = all_letters.select{ |k, v| v == 7 && !letters_for_4(separate_numbers).include?(k)}.keys[0] # both at 7
  puts all_letters
  puts bar_to_letter
  letter_to_bar = bar_to_letter.invert
  # end
#   Then, the four digits of the output value can be decoded:

#   cdfeb: 5
#   fcadb: 3
#   cdfeb: 5
#   cdbaf: 3
all_decoded = [
  ['top_right', 'bottom_right', 'bottom_left', 'top', 'top_left', 'bottom'],
  ['top_right', 'bottom_right'],
  ['top_right', 'bottom_left', 'top', 'middle', 'bottom'],
  ['top_right', 'bottom_right', 'top', 'middle', 'bottom'],
  ['top_right', 'top_left', 'middle', 'bottom_right'],
  ['top_left', 'bottom_right', 'top', 'middle', 'bottom'],
  ['bottom_right', 'bottom_left', 'top', 'top_left', 'bottom', 'middle'],
  ['top', 'top_right', 'bottom_right'],
  ['top_right', 'bottom_right', 'bottom_left', 'top', 'top_left', 'bottom', 'middle'],
  ['top_right', 'bottom_right', 'top', 'top_left', 'bottom', 'middle']
]
  entry_ouput = []
  codes[1].split(' ').each do |coded_digit|
    positions = []
    coded_digit.split(//).each do |letter|
      positions.push(letter_to_bar[letter])
    end
    result = all_decoded.each_with_index do |decoded_position, index|
      if decoded_position.sort == positions.sort
        entry_ouput.push(index)
      end
    end
  end
  sum += entry_ouput.join.to_i
  puts sum
end

puts "the total is #{sum}"
