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

class Hello

end
