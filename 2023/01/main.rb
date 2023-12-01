require 'csv'


file_data = CSV.read("input.csv")

numbers = []
file_data.each do |calibration|
  transformed_calibration = calibration[0].gsub(/[a-z]/i, '')
  numbers << "#{transformed_calibration[0]}#{transformed_calibration[-1]}".to_i
end

puts "The first puzzle of the first day's result is: #{numbers.sum}"




def propose_number_for_string(string)
  return 1 if string.start_with?('one') || string.start_with?('1')
  return 2 if string.start_with?('two') || string.start_with?('2')
  return 3 if string.start_with?('three') || string.start_with?('3')
  return 4 if string.start_with?('four') || string.start_with?('4')
  return 5 if string.start_with?('five') || string.start_with?('5')
  return 6 if string.start_with?('six') || string.start_with?('6')
  return 7 if string.start_with?('seven') || string.start_with?('7')
  return 8 if string.start_with?('eight') || string.start_with?('8')
  return 9 if string.start_with?('nine') || string.start_with?('9')
end

numbers_2 = []
file_data.each do |calibration|
  cal = calibration[0]
  
  digits = []
  while cal.length > 0
    digit = propose_number_for_string(cal)
    digits.push(digit) unless digit.nil? 
    cal.slice!(0)
  end
  numbers_2 << "#{digits[0]}#{digits[-1]}".to_i
end

puts "For the second puzzle, the result is: #{numbers_2.sum}"
