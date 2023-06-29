require 'pry'

file = File.open('input.txt')
initial_state = file.readlines.map(&:chomp)

PAIRS = {')' => '(', ']' => '[', '>' => '<', '}' => '{'}
ERROR_COST = {')' => 3, ']' => 57, '>' => 25137, '}' => 1197 }
FINISH_COST = {'(' => 1, '[' => 2, '<' => 4, '{' => 3 }

errors = []
not_finished = []
initial_state.each do |line|
  stock = []
  error = nil
  line.chars.each do |sym|
    if PAIRS.values.include?(sym)
      stock << sym
    else
      if PAIRS[sym] == stock.last
        stock.pop
      else
        error = sym
      end
    end
    break if error
  end
  if error
    errors << error
  else
    not_finished << stock
  end
end

p errors
points = errors.map{ |err| ERROR_COST[err] }
p points.sum

cost = 0
cost_arr = not_finished.map do |line|
  line.reverse.reduce(0) do |sum, sym|
    5 * sum + FINISH_COST[sym]
  end
end

p cost_arr
p cost_arr.sort[cost_arr.length/2]
