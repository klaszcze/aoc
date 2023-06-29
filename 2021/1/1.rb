file = File.open('input.txt')
file_data = file.readlines.map(&:chomp).map(&:to_i)

counter = 0

file_data.each_index do |n|
  next if n < 3
  if file_data[n] + file_data[n-1] + file_data[n-2] > file_data[n-1] + file_data[n-2] + file_data[n-3]
    counter += 1
  end
end

p file_data.size
p counter


