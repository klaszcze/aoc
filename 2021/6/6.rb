require 'pry'

file = File.open('input.txt')
initial_state = file.readlines.first.split(',').map(&:to_i)

initial_state
fish_array = Array.new(9, 0)

initial_state.each do |fish|
  fish_array[fish] += 1
end

p fish_array

256.times do
  fish_array_dup = Array.new(9, 0)
  fish_array.each_with_index do |fish_count, index|
    fish_array_dup[index - 1] = fish_count
  end
  fish_array_dup[6] += fish_array[0]
  fish_array = fish_array_dup
end

p fish_array
p fish_array.sum

# p data.size

