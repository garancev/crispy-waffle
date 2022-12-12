require 'csv'
file_data_1 = CSV.read("input.csv", col_sep: ':')

puts 'welcome to day 11!'

@is_divisible = ->(b, a) { (a % b) == 0 }
@maybe_divide = ->(b, a) { (a % b) == 0 ? a / b : a}
@add = ->(a, b) { a + b }
# @add_and_divide = ->(a, b) { (a + b) / 3 }
@multiply = ->(a, b) { a * b}
# @multiply_and_divide = ->(a, b) { (a * b) / 3}
@multiply_self = ->(a) { a * a }
# @multiply_self_and_divide = ->(a) { (a * a) / 3 }
@monkeys = []

@lcm = 1
def find_lcm
  @lcm = @monkeys.map { |m| m[:modulo] }.reduce(:lcm)
  print "lcm:"
  print @lcm
  puts
end

def curry_operation(attributes)
  operation = attributes[2][1].strip.split(' ')
  if operation[4] == 'old'
    return @multiply_self.curry
  end
  if operation[3] == '*'
    return @multiply.curry[operation[4].to_i]
  end
  return @add.curry[operation[4].to_i]
end

def make_manageable(value)
  # -> (n) { n % monkeys.map(&:test).reduce(:lcm) }
  value % @lcm
end

def play_turn(monkey, divide_by_3)
  monkey[:items].each do |item|
    new_value = monkey[:op][item]
    new_new_value = divide_by_3 ? new_value / 3 : new_value % @lcm
    send_to = monkey[:test][new_new_value] ? monkey[:true] : monkey[:false]
    @monkeys[send_to][:items] << new_new_value
    monkey[:inspected] += 1
  end
  monkey[:items].clear
end

def play_round(divide_by_3)
  @monkeys.each do |monkey|
    play_turn(monkey, divide_by_3)
  end
end

def decrypt_notes(notes)
  notes.each_slice(7) do |attributes|
    monkey = {inspected: 0}
    monkey.store(:items, attributes[1][1].strip.split(', ').map(&:to_i))

    operation = curry_operation(attributes)
    monkey.store(:op, operation)

    monkey_test = attributes[3][1].strip.split(' ')[2].to_i
    test_worry = @is_divisible.curry[monkey_test]
    maybe_dividing = @maybe_divide.curry[monkey_test]
    monkey.store(:test, test_worry)
    monkey.store(:modulo, monkey_test)

    monkey.store(:true, attributes[4][1].strip.split(' ')[3].to_i)
    monkey.store(:false, attributes[5][1].strip.split(' ')[3].to_i)
    @monkeys.push(monkey)
  end
end

def calculate
  inspected_only = @monkeys.map { |m| m[:inspected]}
  inspected_only.max(2).inject(:*)
end

def print_inspection
  @monkeys.each_with_index do |monkey, index|
    puts "Monkey #{index} inspected items #{monkey[:inspected]} times."
  end
end
@inspect_me = [1, 20, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

def calculate_monkey_business(notes, rounds, divide_by_3)
  decrypt_notes(notes)
  find_lcm
  rounds.times do |round|
    play_round(divide_by_3)
    if @inspect_me.include?(round + 1)
      puts "~~~~ After round #{round + 1} ~~~~"
      print_inspection
    end
  end
  calculate
end
def calculate_monkey_business_manageable(notes)
  calculate_monkey_business(notes, 20, true)
  @monkeys.clear
end
def calculate_monkey_business_crazy(notes)
  calculate_monkey_business(notes, 10_000, false)
end
puts 'What is the level of monkey business after 20 rounds of stuff-slinging simian shenanigans?'
puts calculate_monkey_business_manageable(file_data_1)

puts "~~~ and what is the level of monkey business after 10000 rounds? ~~~"
puts calculate_monkey_business_crazy(file_data_1)

