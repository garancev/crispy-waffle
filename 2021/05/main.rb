require 'matrix'

file_data = File.readlines("input.csv").map(&:chomp)

puts 'welcome to day 5!'

size, default_value = 10, 0
arr_2d = Array.new(size){Array.new(size,default_value)}

directions = file_data.map do |vent|
  direction = vent.split(' -> ')
  all_split = direction.map do |coordinates|
    coordinates.split(',')
  end
end

map_of_vents = Matrix.zero(1000, 1000)

def find_range(start, finish)
  if start > finish
    return [finish, start]
  end
  return [start, finish]
end

# Bresenham implementation from http://www.codecodex.com/wiki/Bresenham's_line_algorithm
def bresenham_0(dx, dy)
  dy = dy * 2
  y  = 1
  err = 0
  pos = []
  for x in 0..dx
    pos << [x, y/2]
    err += dy
    while err > dx
      y += 1
      err -= dx
    end
  end
  pos
end

# A straight line between two given points.
# (x0,y0) -> (x1,y1)
def bresenham(x0, y0, x1, y1)
  dx, dy = x1 - x0, y1 - y0
  sx, sy = dx<=>0, dy<=>0       # sign flag (-1,0 or 1)
  ax, ay = dx.abs, dy.abs
  if ax >= ay
    bresenham_0(ax, ay).map! {|x,y| [x0 + x * sx, y0 + y * sy]}
  else
    bresenham_0(ay, ax).map! {|y,x| [x0 + x * sx, y0 + y * sy]}
  end
end


directions.each do |coordinate|
  start_x = coordinate[0][0].to_i
  end_x = coordinate[1][0].to_i
  start_y = coordinate[0][1].to_i
  end_y = coordinate[1][1].to_i
  # if start_y == end_y
  #   range = find_range(start_x, end_x)
  #   for position in range[0]..range[1]
  #     map_of_vents[position, start_y] += 1
  #   end
  # elsif start_x == end_x
  #   range = find_range(start_y, end_y)
  #   for position in range[0]..range[1]
  #     map_of_vents[start_x, position] += 1
  #   end
  # else
    # puts 'bresenham'
    to_cover = bresenham(start_x, start_y, end_x, end_y)
    to_cover.each do |x, y|
      map_of_vents[x, y] += 1
    end
  # end
end

puts "there are #{map_of_vents.count { |number| number > 1 }} points where lines overlap!"
