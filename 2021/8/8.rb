require 'pry'

file = File.open('input.txt')
initial_state = file.readlines.map(&:chomp)

output = initial_state.map { |line| line.split(' | ').last.split }
input = initial_state.map { |line| line.split(' | ').first.split }

number_count = 0
sizes = [2, 3, 4, 7]

output.flatten.each do |digit|
  number_count += 1 if sizes.include?(digit.size)
end

output_array = []

def anagram?(w1, w2)
  return false unless w1.size == w2.size
  w1.chars.difference(w2.chars).empty?
end

number_count = 0

input.each_with_index do |line, index|
  zero = nil
  one = nil
  two = nil
  three = nil
  four = nil
  five = nil
  six = nil
  seven = nil
  eight = nil
  nine = nil

  new_line = line.dup
  line.each do |digit|
    case digit.size
    when 2
      one = digit
      new_line.delete(digit)
    when 3
      seven = digit
      new_line.delete(digit)
    when 4
      four = digit
      new_line.delete(digit)
    when 7
      eight = digit
      new_line.delete(digit)
    end
  end
  line = new_line

  six_sizes = line.select { |digit| digit.size == 6 }
  six_sizes.each do |digit|
    if four.chars.difference(digit.chars).empty?
      nine = digit
    elsif seven.chars.difference(digit.chars).empty?
      zero = digit
    else
      six = digit
    end
  end

  five_sizes = line.select { |digit| digit.size == 5 }

  five_sizes.each do |digit|
    if seven.chars.difference(digit.chars).empty?
      three = digit
    elsif digit.chars.difference(nine.chars).empty?
      five = digit
    else
      two = digit
    end
  end

  def anagram?(w1, w2)
    return false unless w1.size == w2.size
    w1.chars.difference(w2.chars).empty?
  end

  line = output[index]
  number = line.map do |digit|
    case digit.size
    when 2
      1
    when 3
      7
    when 4
      4
    when 7
      8
    when 6
      if anagram?(digit, nine)
        9
      elsif anagram?(digit, six)
        6
      else
        0
      end
    when 5
      if anagram?(digit, three)
        3
      elsif anagram?(digit, five)
        5
      else
        2
      end
    end
  end
  number_count += number.join.to_i
end

p number_count


