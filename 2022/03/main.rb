require 'csv'
file_data = CSV.read("input.csv")

puts 'welcome to day 3!'
letters_array = [*'a'..'z', *'A'..'Z']
@letters_hash = Hash.new
letters_array.each_with_index do |letter, index|
  @letters_hash[letter] = index + 1
end

def content_list_rucksack(rucksack)
  compartment_size = rucksack.size / 2
  compartment_1 = rucksack[0, compartment_size].split(//)
  compartment_2 = rucksack[compartment_size, compartment_size].split(//)
  sorted_1 = compartment_1.uniq.sort #don't care that some items are duplicate within a compartment
  sorted_2 = compartment_2.uniq.sort
  sorted_1.concat(sorted_2)
end

def points_for_rucksack(rucksack)
  total = content_list_rucksack(rucksack)
  @letters_hash[total.tally.key(2)]
end

def sum_all_points(rucksacks)
  # puts rucksacks
  rucksacks.reduce(0) do |sum, content|
    sum + points_for_rucksack(content[0])
  end
end

def sum_by_group(rucksacks)
  group = []
  rucksacks.each_slice(3) {|tuple| group.push(tuple) }
  group.reduce(0) do |sum, rucksacks_from_group|
    all_contents = rucksacks_from_group.map do |rucksack|
      content_list_rucksack(rucksack[0]).uniq
    end.flatten
    sum + @letters_hash[all_contents.tally.key(3)]
  end
end

puts 'how many points do I have at the end?'
puts sum_all_points(file_data)

puts "~~~ and what is the priority sum for all groups? ~~~"
puts sum_by_group(file_data)

