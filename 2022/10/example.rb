require 'csv'
file_data_1 = CSV.read("example1.csv", col_sep: ' ')
file_data = CSV.read("example2.csv", col_sep: ' ')

puts 'welcome to day 10!'

@add = 'addx'
@noop = 'noop'

###.....................................


def visualise_screen(crt_rows)
  puts
  crt_rows.each do |row|
    puts row
  end
end
# visualise_screen([])


def execute_program(instructions)
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
    puts "Sprite position: #{sprite_position}"
    puts
    if instruction[0] == @add
      puts "Start cycle #{register.size}: Begin executing addx #{instruction[1]}"
      puts "During cycle #{register.size}: CRT draws pixel in position #{crt_rows[current_row].size} on row #{current_row} (#{crt_rows[current_row].inspect})"
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      puts "Current CRT row: #{crt_rows[current_row]}"
      register << register.last
      current_row = (register.size - 1) / 40
      puts
      puts "During cycle #{register.size}: CRT draws pixel in position #{crt_rows[current_row].size} on row #{current_row} (#{crt_rows[current_row].inspect})"
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      puts "Current CRT row: #{crt_rows[current_row]}"
      register << register.last + instruction[1].to_i
      puts "End of cycle #{register.size}: finish executing addx #{instruction[1]} (Register X is now #{register.last})"
    else
      puts "Start cycle #{register.size}: Begin executing noop #{instruction[1]}"
      puts "During cycle #{register.size}: CRT draws pixel in position #{crt_rows[current_row].size} on row #{current_row} (#{crt_rows[current_row].inspect})"
      crt_rows[current_row] << sprite_position[crt_rows[current_row].size]
      puts "Current CRT row: #{crt_rows[current_row]}"
      puts "End of cycle #{register.size}: finish executing noop"
      register << register.last
    end
  end
  crt_rows
end

def sum_signal_strength(program)
  register = execute_program(program)
  register[19] * 20 + register[59] * 60 + register[99] * 100 + register[139] * 140 + register[179] * 180 + register[219] * 220
end
def draw_on_screen(program)
  crt_rows = execute_program(program)
  visualise_screen(crt_rows)
end

puts 'What is the sum of these six signal strengths?'
# puts execute_program(file_data_1)
# puts sum_signal_strength(file_data)

puts "~~~ and how many positions does the tail of the rope visit at least once? ~~~"
draw_on_screen(file_data)
