file = File.open('input.txt')
file_data = file.readlines.map(&:chomp).map(&:to_i)

max = [0, 0, 0]
sum = 0
file_data.each do |kcal|
  if kcal == 0
    if sum > max[0]
      max[2] = max[1]
      max[1] = max[0]
      max[0] = sum
    elsif sum > max[1]
      max[2] = max[1]
      max[1] = sum
    elsif sum > max[2]
      max[2] = sum
    end
    sum = 0
  else
    sum += kcal
  end
end

if sum > max[0]
  max[2] = max[1]
  max[1] = max[0]
  max[0] = sum
elsif sum > max[1]
  max[2] = max[1]
  max[1] = sum
elsif sum > max[2]
  max[2] = sum
end
p max.sum

