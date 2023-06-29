require 'pry'

file = File.open('input.txt')
file_data = file.readlines.map(&:chomp)

numbers = file_data.shift.split(',')
# p numbers
bingo_arrays = []
array = nil
file_data.each do |row|
  if row == ''
    array = Array.new
  else
    array << row.split
    bingo_arrays << array if array.size == 5
  end
end

def check_lines(array)
  array.each do |row|
    return true if row.uniq.size <= 1
  end
  false
end

def check_columns(array)
  (0..4).each do |index|
    return true if array.all? { |row| row[index] == 'X'}
  end
  false
end

def bingo(array, num)
  array.each do |row|
    row.map! { |x| x == num ? 'X' : x }
  end
end

won_array = nil
won_number = nil

(0..bingo_arrays.size).each do |index|
  number = numbers[index]

  new_bingo_arrays = bingo_arrays.dup
  bingo_arrays.each do |bingo_array|
    bingo(bingo_array, number)

    won = check_lines(bingo_array) || check_columns(bingo_array)

    if won
      won_array = bingo_array
      won_number = number
      new_bingo_arrays.reject! { |a| a == won_array }
    end
    break if bingo_arrays.size == 1
  end
  bingo_arrays = new_bingo_arrays
end

p won_array.flatten.map(&:to_i).sum * won_number.to_i

p won_array
p won_number
#
nums, *cards = File.read('input.txt').split("\n\n")
nums = nums.split(',').map(&:to_i)
cards = cards.map {|c| (c.lines.map {|l| l.scan(/\d+/).map(&:to_i) }) }
cards = cards.map {|c| [c, c.transpose] }

# cp1 = Marshal.load(Marshal.dump(cards))
# nums.each do |n|
#   break if cp1.any? {|c| c.any? {|t| t.any? {|l| l.empty? } } }
#   cp1.each {|c| c.each {|t| t.each {|l| l.delete(n) } } }
#   $n = n
# end
# p $n
# p cp1.filter {|c| c.any? {|t| t.any? {|l| l.empty? } } }[0][0]
# p $n*cp1.filter {|c| c.any? {|t| t.any? {|l| l.empty? } } }[0][0].flatten.sum

nums.each do |n|
  break if cards.count {|c| c.all? {|t| t.all? {|l| !l.empty? } } } <= 1
  cards.each {|c| c.each {|t| t.each {|l| l.delete(n) } } }
  $n = n
end
c = cards.filter {|c| c.all? {|t| t.all? {|l| !l.empty? } } }[0]
nums.each do |n|
  break if c.any? {|t| t.any? {|l| l.empty? } }
  cards.each {|c| c.each {|t| t.each {|l| l.delete(n) } } }
  $n = n
end
p $n
p c[0]
p $n*c[0].flatten.sum
#
#
# 64 75 20 77 82
# 46 63 83 69 41
# 44 15 73 35 61
# 99 71  4 43 72
# 76 81 93 23  0
