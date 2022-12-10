require 'csv'
file_data = CSV.read("input.csv", col_sep: ' ')

puts 'welcome to day 10!'

@add = 'addx'
@noop = 'noop'
def calculate_register(instructions)
  register = [1]
  instructions.each_with_index do |instruction, index|
    if instruction[0] == @noop
      register << register.last
    else
      register << register.last
      register << register.last + instruction[1].to_i
    end
  end
  register
end

def sum_signal_strength(program)
  register = calculate_register(program)
  register[19] * 20 + register[59] * 60 + register[99] * 100 + register[139] * 140 + register[179] * 180 + register[219] * 220
end

def visualise_screen(crt_rows)
  puts crt_rows.size
  crt_rows.each do |row|
    print '>'
    puts row
  end
end

def crt_draws(instructions)
  register = [1]
  crt_rows = ['', '', '', '', '', '']
  instructions.each_with_index do |instruction, index|
    current_row = (register.size - 1) / 40
    sprite_position = ''
    (0..40).each do |pixel|
      if pixel == register.last - 1 || pixel == register.last || pixel == register.last + 1
        sprite_position << '#'
      else
        sprite_position << '.'
      end
    end
    if instruction[0] == @add
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      register << register.last
      current_row = (register.size - 1) / 40
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      register << register.last + instruction[1].to_i
    else
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      register << register.last
    end
  end
  crt_rows
end

def draw_on_screen(program)
  rows = crt_draws(program)
  visualise_screen(rows)
end

puts 'What is the sum of these six signal strengths?'
puts sum_signal_strength(file_data)

puts "~~~ and What eight capital letters appear on your CRT? ~~~"
draw_on_screen(file_data)