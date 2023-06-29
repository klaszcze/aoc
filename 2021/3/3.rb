require 'pry'

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp).map { |x| x.split('').map(&:to_i) }

length = file_data.first.size
array_size = file_data.size
gamma_array = Array.new(length, 0)

file_data.each do |row|
  row.each_with_index do |val, i|
    gamma_array[i] += val
  end
end

hl = array_size/2

gamma = gamma_array.map do |cell|
  cell > hl ? 1 : 0
end

eps = gamma_array.map do |cell|
  cell > hl ? 0 : 1
end

p gamma
g = gamma.join.to_i(2)
e = eps.join.to_i(2)

p g * e

oxy_array = file_data.dup
index = 0

while array_size != 1 do
  count = 0
  oxy_array.each do |row|
    count += row[index]
  end

  if ( array_size / 2.0 ) <= count
    oxy_array.select! do |row|
      row[index] == 1
    end
  elsif ( array_size / 2.0 ) > count
    oxy_array.select! do |row|
      row[index] == 0
    end
  end
  index += 1
  array_size = oxy_array.size
end

p oxy_array
b = oxy_array.join.to_i(2)

o2_array = file_data.dup
index = 0

array_size = file_data.size
while array_size != 1 do
  count = 0
  o2_array.each do |row|
    count += row[index]
  end

  if ( array_size / 2.0 ) > count
    o2_array.select! do |row|
      row[index] == 1
    end
  elsif ( array_size / 2.0 ) <= count
    o2_array.select! do |row|
      row[index] == 0
    end
  end
  index += 1
  array_size = o2_array.size
end

p o2_array
a = o2_array.join.to_i(2)

p a*b


