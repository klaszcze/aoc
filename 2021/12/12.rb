require 'pry'

file = File.open('input.txt')
@initial_state = file.readlines.map(&:chomp).map{ |x| x.chars.map(&:to_i) }


