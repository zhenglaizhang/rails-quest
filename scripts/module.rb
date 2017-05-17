class Triangle
  SIDES = 3

  def area
  end
end

class Square
  SIDES = 5

  def initialize(side_length)
    @side_length = side_length
  end

  def area
    @side_length * @side_length
  end
end

puts "A rectangle has #{Triangle::SIDES} sides"
sq = Square.new(3)
puts "Area of square=#{sq.area}"

puts Math::E
puts Math.sin(Math::PI / 6.0)


## sec module
p [1, 2, 3, 4].inject(:+)
p ('a'..'m').inject(:+)

module Summable
  def sum
    inject(:+)
  end
end

class Array
  include Summable
end

class Range
  include Summable
end

require_relative 'vowel_finder'
class VowlerFinder
  include Summable
end

p [1, 2, 3, 4].sum
p ('a'..'m').sum
