file_1_data = File.read("example1.csv")
file_2_data = File.read("example2.csv")
file_3_data = File.read("example3.csv")
file_4_data = File.read("example4.csv")
file_5_data = File.read("example5.csv")

puts 'welcome to day 6!'

def find_index(data_stream, buffer_size)
  index = -1
  data_stream.each_cons(buffer_size) do |buffer|
    index = index + 1
    break if buffer.uniq.length == buffer.length
  end
  index + buffer_size
end
def find_marker_index(data_stream)
  find_index(data_stream, 4)
end

def find_message_index(data_stream)
  find_index(data_stream, 14)
end

puts 'What is the marker\'s index?'
puts find_marker_index(file_1_data.split(//))
puts find_marker_index(file_2_data.split(//))
puts find_marker_index(file_3_data.split(//))
puts find_marker_index(file_4_data.split(//))
puts find_marker_index(file_5_data.split(//))

puts '~~~ An what\'s the start of the message index? ~~~'
puts find_message_index(file_1_data.split(//))
puts find_message_index(file_2_data.split(//))
puts find_message_index(file_3_data.split(//))
puts find_message_index(file_4_data.split(//))
puts find_message_index(file_5_data.split(//))