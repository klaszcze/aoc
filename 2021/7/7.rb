require 'pry'

file = File.open('input.txt')
initial_state = file.readlines.first.split(',').map(&:to_i)

p initial_state

sorted = initial_state.sort
length = initial_state.count

median = if sorted.count % 2 == 0
  first_half = (sorted[0...(length/2)])
  second_half = (sorted[(length/2)..-1])

  first_median = first_half[-1]
  second_median = second_half[0]

  median = ((first_median + second_median).to_f / 2.to_f)
  median.to_i
else
  median = sorted[(length/2).floor]
  median.to_i
end

p median

fuel = 0
initial_state.each do |position|
  fuel += (position - median).abs
end

p fuel

avg = (initial_state.sum.to_f / initial_state.size).floor

fuel2 = 0

def calc_fuel(dist)
  (0..dist).sum
end

initial_state.each do |position|
  dist = (position - avg).abs
  fuel2 += calc_fuel(dist)
end

p fuel2
