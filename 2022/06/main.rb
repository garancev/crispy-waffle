file_data = File.read("input.csv")

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
puts find_marker_index(file_data.split(//))

puts '~~~ An what\'s the start of the message index? ~~~'
puts find_message_index(file_data.split(//))