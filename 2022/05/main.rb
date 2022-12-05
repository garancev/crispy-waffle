require 'csv'
col_sep = ' '
file_data = CSV.read("input.csv", col_sep: col_sep)

puts 'welcome to day 5!'
@piles_count = 0
@piles = []


def piles_setup(crates)
  crates.reverse.each_with_index do |configuration, index|
    if index == 0
      @piles_count = (configuration.size + 1) / 3
    else
      offset_nil_column = 0
      configuration.each_with_index do |crate, crate_index|
        if !crate.nil?
          real_index = crate_index
          if offset_nil_column > 0
            real_index = crate_index - offset_nil_column + offset_nil_column/4
          end

          @piles[real_index] = [] if @piles[real_index].nil?
          @piles[real_index].push(crate)
          # offset_nil_column = 0
        else
          offset_nil_column = offset_nil_column + 1
          # gotta count how many nils to know the index offset
        end
      end
    end
  end
end

def run_instructions_9000(instructions)
  instructions.each do |instruction|
    nb_of_crates_to_move = instruction[1].to_i
    from_crate = instruction[3].to_i - 1
    to_crate = instruction[5].to_i - 1
    nb_of_crates_to_move.times do
      @piles[to_crate].push(@piles[from_crate].pop)
    end
  end
end

def run_instructions_9001(instructions)
  instructions.each do |instruction|
    nb_of_crates_to_move = instruction[1].to_i
    from_crate = instruction[3].to_i - 1
    to_crate = instruction[5].to_i - 1
    @piles[from_crate].last(nb_of_crates_to_move).each do |crate|
      @piles[to_crate].push(crate)
    end
    nb_of_crates_to_move.times do
      @piles[from_crate].pop
    end
  end
end

def setup(procedure)
  crates = []
  instructions = []
  index_of_split = 0
  procedure.each_with_index do |configuration, index|
    instructions.push(configuration) if index_of_split > 0
    index_of_split = index if configuration == []
    crates.push(configuration) if index_of_split == 0
  end
  piles_setup(crates)
  instructions
end
def find_tops
  @piles.reduce('') do |top, pile|
    top + pile[pile.size - 1][1]
  end
end

def find_top_of_stacks(procedure)
  instructions = setup(procedure)
  run_instructions_9000(instructions)
  find_tops
end

def find_top_of_stacks_9001(procedure)
  instructions = setup(procedure)
  run_instructions_9001(instructions)
  find_tops
end

puts 'What crates ends up on top of each stack?'
puts find_top_of_stacks(file_data)

puts "~~~ and how many pairs are overlapping? ~~~"
puts find_top_of_stacks_9001(file_data)
# not PPPQWQPNF

