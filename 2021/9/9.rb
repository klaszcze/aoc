require 'pry'

file = File.open('input.txt')
@initial_state = file.readlines.map(&:chomp).map{ |x| x.chars.map(&:to_i) }


low_points = []
risk_level = 0

@initial_state.each_with_index do |line, line_index|
  line.each_with_index do |el, index|
    next if index > 0 && line[index - 1] <= el
    next if line[index + 1] && line[index + 1] <= el
    next if line_index > 0 && @initial_state[line_index - 1][index] <= el
    next if @initial_state[line_index + 1] && @initial_state[line_index + 1][index] <= el

    low_points << [el, line_index, index]
  end
end

p low_points

@basin_array = Array.new(@initial_state.size) { Array.new(@initial_state.first.size, 0) }

index = 1

def flood_fill(poz, index)
  return if @initial_state[poz[0]][poz[1]] == 9 || @basin_array[poz[0]][poz[1]] != 0
  @basin_array[poz[0]][poz[1]] = index
  flood_fill([poz[0] - 1, poz[1]], index) unless poz[0] == 0
  flood_fill([poz[0] + 1, poz[1]], index) unless poz[0] == @initial_state.size - 1
  flood_fill([poz[0], poz[1] - 1], index) unless poz[1] == 0
  flood_fill([poz[0], poz[1] + 1], index) unless poz[1] == @initial_state.first.size - 1
end

low_points.each do |point|
  flood_fill([point[1], point[2]], index)
  index += 1
end

p @basin_array
p @basin_array.flatten.tally
p @basin_array.flatten.tally.values.sort