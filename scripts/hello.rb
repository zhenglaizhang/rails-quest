#!/usr/bin/ruby

def fact(n)
  if n == 0
    1
  else
    n * fact(n - 1)
  end
end


def sum(a, b)
  a + b
end

puts fact(ARGV[0].to_i)
puts sum(1, 2)
puts sum('a', 'b')


puts "It is now #{Time.now}"


10.times do
  puts 'hello world!'
end
10.times {puts 'hello world'}

# error
# print '2+3 is equal to ' + 2 + 3
puts '2+3 is equal to ' + (2 + 3).to_s
puts "2+3 is equal to #{2 + 3}"
puts (10 / 3)
puts (10.to_f / 3.to_f)
puts (10.0 / 3)

class Pet
  # attributes
  attr_accessor :name, :age, :gender, :color

  def to_s
    "Pet(name=#{name}, age=#{age}, gender=#{gender}), color=#{color}}"
  end
end

class Cat < Pet
end

class Dog < Pet
  def bark(i)
    i.times {puts 'Woof!'}
  end
end

class Snake < Pet
  attr_accessor :length
end

obj = Dog.new
obj.age = 12
puts obj
obj.bark(12)

# Kernel is a special class (actually, a module—but don’t worry about that until Chapter 6!) whose methods are made available in every class and scope throughout Ruby
puts 1.class
puts true.class

p 'abcD'.swapcase

1.upto(3) {|i| print i}
puts
1.downto(-1) {|i| print i}
puts
0.step(50, 5) {|i| print i}
puts
1.upto(2) {puts 'hello'}
puts


# todo basic multi line string
multi_line = %q{This is
  multile line
end
}
puts multi_line
multi_line = 'THis is
  another line
end'
puts multi_line

# here document
x = <<END_STR
first line
second line
END_STR
puts x

puts 'abc' * 5

puts 'abc' > 'abd'
puts 'x'.ord


# sec: regular expression
puts 'foo bar foo'.sub('foo', 'bar')
puts 'foo bar foo'.gsub('foo', 'bar')
# /^../ means “any two characters immediately after the start of a line.
puts 'foo bar foo'.sub(/^../, 'hell')
puts 'foo bar
foo bar'.gsub(/^../, 'hell')
puts 'foo bar
foo bar'.gsub(/\A../, 'hell')

# If you want to anchor to the absolute start or end of a string, you can use \A and \z, respectively,
# whereas ^ and $ anchor to the starts and ends of lines within a string

'xyz'.scan(/./) {|letter| puts letter}
'This is a test'.scan(/../) {|x| puts x}
2.times { puts }
'This is a test'.scan(/\w\w/) {|x| puts x}

'The car costs $1000 and the cat costs $10'.scan(/\d+/) {|d| puts d}


# build env.
require 'rbconfig'
include RbConfig
puts CONFIG.keys
puts CONFIG['host']
puts CONFIG['libdir']

