require 'csv'


file_data = CSV.read("example1.csv")

numbers = []
file_data.each do |calibration|
  transformed_calibration = calibration[0].gsub(/[a-z]/i, '')
  numbers << "#{transformed_calibration[0]}#{transformed_calibration[-1]}".to_i
end

puts "For the first example, the result is: #{numbers.sum}"

file_2_data = CSV.read("example2.csv")


def propose_number_and_size_for_string(string)
  return [1, 2] if string.start_with?('one')
  return [2, 2] if string.start_with?('two')
  return [3, 4] if string.start_with?('three')
  return [4, 3] if string.start_with?('four')
  return [5, 3] if string.start_with?('five')
  return [6, 2] if string.start_with?('six')
  return [7, 4] if string.start_with?('seven')
  return [8, 4] if string.start_with?('eight')
  return [9, 3] if string.start_with?('nine')
end

numbers_2 = []
file_2_data.each do |calibration|
  cal = calibration[0]
  digits = []

  while cal.length > 0
    #puts cal
    digit = propose_number_and_size_for_string(cal)
    if digit.nil? 
      if cal.start_with?(/[0-9]/)
        #puts "found a real number: #{cal[0]}"
        digits.push(cal[0])
      end
      cal.slice!(0)
    else
        #puts "found a written number: #{digit}"
        digits.push(digit[0])
      cal.slice!(0..digit[1])
    end
  end
  puts "#{digits}"
  numbers_2 << "#{digits[0]}#{digits[-1]}".to_i
end
puts "#{numbers_2}"

puts "For the second example, the result is: #{numbers_2.sum}"
