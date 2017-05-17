class VowlerFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  def each
    @string.scan(/[aeiou]/) {|vowel| yield vowel}
  end
end

vf = VowlerFinder.new('the quick brown for jumped')
p vf.inject(:+)
