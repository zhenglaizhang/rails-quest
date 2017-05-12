# todo https://www.toptal.com/ruby/ruby-metaprogramming-cooler-than-it-sounds
class Developer
  p self

  # class method
  def self.backend
    # Inside class methods, self refers to the class itself
    'I am a backend developer'
  end

  # instance method
  def frontend
    'I am a frontend developer'
    self
  end
end

# class Developer is actually an object
# Developer is an instance, it is an instance of class Class
# see https://uploads.toptal.io/blog/image/91785/toptal-blog-image-1446120487914-384fae8f419347d455a43dab6e20cf25.jpg

p Developer.class # Class
p Class.superclass # Module
p Module.superclass # Object
p Object.superclass # BasicObject

Developer.new.frontend


# Every piece of code executed in Ruby is executed against a particular self. When the Ruby interpreter executes any code it always keeps track of the value self for any given line. self is always referring to some object but that object can change based on the code executed. For example, inside a class definition, the self refers to the class itself which is an instance of class Class.


# Every object in Ruby has its own metaclass also known as singleton class and eigenclass. Class method frontend that we defined earlier is nothing but an instance method defined in the metaclass for the object Developer
# A metaclass is essentially a class that Ruby creates and inserts into the inheritance hierarchy to hold class methods, thus not interfering with instances that are created from the class.


# The difference between class methods and singleton methods is that class methods are available to all instances of a class object while singleton methods are available only to that single instance
ex = 'a string obj'
def ex.something
  self.upcase
end

p ex.something

# same as:

# todo fix it
# ex2 = 'another string obj'
# class << ex2
#   def ex2.anotherthing
#     self.upcase
#   end
# end
#
# p ex2.anotherthing
