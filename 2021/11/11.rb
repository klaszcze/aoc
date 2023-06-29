require 'pry'

file = File.open('input.txt')
@initial_state = file.readlines.map(&:chomp).map{ |x| x.chars.map(&:to_i) }

@flash_count = 0

def flush(line_index, index)
  @flash_count += 1
  @flushed[line_index][index] = true
  increase_cell(line_index + 1, index) unless line_index == @initial_state.size - 1
  increase_cell(line_index + 1, index - 1) unless line_index == @initial_state.size - 1 || index == 0
  increase_cell(line_index + 1, index + 1) unless line_index == @initial_state.size - 1 || index ==  @initial_state.first.size - 1
  increase_cell(line_index - 1, index) unless line_index == 0
  increase_cell(line_index - 1, index - 1) unless line_index == 0 || index == 0
  increase_cell(line_index - 1, index + 1) unless line_index == 0 || index ==  @initial_state.first.size - 1
  increase_cell(line_index, index - 1) unless index == 0
  increase_cell(line_index, index + 1) unless index ==  @initial_state.first.size - 1
end

def increase_cell(line_index, index)
  return if @flushed[line_index][index]
  if @initial_state[line_index][index] == 9
    flush(line_index, index)
    @initial_state[line_index][index] = 0
  else
    @initial_state[line_index][index] += 1
  end
end

1000.times do |n|
  @flushed = Array.new(@initial_state.size) { Array.new(@initial_state.first.size, false) }
  @initial_state.each_with_index do |line, line_index|
    line.each_with_index do |_el, index|
      increase_cell(line_index, index)
    end
  end
  if @flushed.flatten.uniq == [true]
    p n
  end
end

p @initial_state
p @flash_count