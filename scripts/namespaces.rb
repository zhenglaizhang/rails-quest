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
