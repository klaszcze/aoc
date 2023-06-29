require 'pry'

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp).map do |x|
  x.split(' -> ').map{ |a| a.split(',').map(&:to_i) }
end

max_size = file_data.flatten.max + 1
coords = Array.new(max_size) { Array.new(max_size, 0) }

overlap_counter = 0

def x_const(data)
  data[0][0] == data[1][0]
end

def y_const(data)
  data[0][1] == data[1][1]
end

file_data.each do |data|
  x_const = x_const(data)
  y_const = y_const(data)
  if x_const
    range = data[0][1] < data[1][1] ? data[0][1]..data[1][1] : data[1][1]..data[0][1]
    range.each do |y_coord|
      coords[data[0][0]][y_coord] += 1
      overlap_counter += 1 if coords[data[0][0]][y_coord] == 2
    end
  elsif y_const
    range = data[0][0] < data[1][0] ? data[0][0]..data[1][0] : data[1][0]..data[0][0]
    range.each do |x_coord|
      coords[x_coord][data[0][1]] += 1
      overlap_counter += 1 if coords[x_coord][data[0][1]] == 2
    end
  else
    x_range = data[0][0] < data[1][0] ? data[0][0]..data[1][0] : data[0][0].downto(data[1][0])
    y_range = data[0][1] < data[1][1] ? (data[0][1]..data[1][1]).to_a : data[0][1].downto(data[1][1]).to_a
    x_range.each_with_index do |x_coord, i|
      coords[x_coord][y_range[i]] += 1
      overlap_counter += 1 if coords[x_coord][y_range[i]] == 2
    end
  end
end

p coords
p overlap_counter



