file = File.open('input.txt')
file_data = file.readlines.map(&:chomp).map{ |x| x.split }

depth = 0
horizontal = 0
aim = 0

file_data.each do |command, counter|
  counter = counter.to_i
  case command
  when 'forward'
    horizontal += counter
    depth += counter*aim
  when 'down'
    aim += counter
  when 'up'
    aim -= counter
  end
end

p horizontal * depth
