# 联极Ruby编程风格指南

我们需要使用统一的Ruby编码风,践行Ruby 的最佳实践，目前是写出可维护的高质量代码。无论你选择何种风格，务必在使用时保持连贯性。

## 目录

* [源代码排版](#源代码排版)
* [语法](#语法)
* [命名](#命名)
* [注释](#注释)
  * [注解](#注解)
  * [Magic Comments](#magic-comments)
* [类与模块](#类与模块)
* [异常](#异常)
* [集合](#集合)
* [数值](#数值)
* [日期与时间](#日期与时间)
* [字符串](#字符串)
* [正则表达式](#正则表达式)
* [百分号字面量](#百分号字面量)
* [元编程](#元编程)
* [其他](#其他)
* [工具](#工具)

## 代码排版

* 使用 `UTF-8` 作为源文件的编码, 请配置编辑器或者IDE。

* 每个缩排层级使用两个**空格**。不要使用制表符,如下所示:

  ```Ruby
  def some_method
    do_stuff
  end
  ```

* 使用 Unix 风格的换行符。
  * 如果是在Windows开发，需要配置Git：

    ```bash
    $ git config --global core.autocrlf true
    ```

* 不要使用 `;` 隔开语句与表达式, 应该只在一行书写一条语句。

  ```Ruby
  puts 'foo', 'bar'
  ```

* 对于没有主体的类，倾向使用单行定义。

  ```Ruby
  # 差
  class FooError < StandardError
  end

  # 一般
  class FooError < StandardError; end

  # 好
  FooError = Class.new(StandardError)
  ```

* 定义方法时，避免单行写法。至少保证单行写法的方法不应该拥有一个以上的表达式。

  ```Ruby
  # 好
  def some_method
    body
  end
  ```

  唯一的一个例外是空方法。

  ```Ruby
  # 好
  def no_op; end
  ```

* 操作符前后适当地添加空格，在逗号 `,`、冒号 `:` 及分号 `;` 之后。(尽管 Ruby 解释器大部分情况下会忽略空格，但适量的空格可以增强代码的可读性。)

  ```Ruby
  sum = 1 + 2
  a, b = 1, 2
  class FooError < StandardError; end
  ```

  唯一的例外是当使用指数操作符时：

  ```Ruby
  # 好
  e = M * c**2
  ```
* `(`、`[` 之后，`]`、`)` 之前，不要添加任何空格。在 `{` 前后，在 `}` 之前添加空格。

  ```Ruby
  # 好
  some(arg).other
  [1, 2, 3].each { |e| puts e }
  ```

  `{` 与 `}` 需要额外说明，因为它们可以同时用在区块、哈希字面量及字符串插值中。

  对于哈希字面量,在大括号两端加上空格．

  ```Ruby
  # 好 - { 之后 与 } 之前有空格
  { one: 1, two: 2 }
  ```

  对于插值表达式，括号内两端不要添加空格。

  ```Ruby
  # 差
  "From: #{ user.first_name }, #{ user.last_name }"

  # 好
  "From: #{user.first_name}, #{user.last_name}"
  ```

* 
  `!` 之后，不要添加任何空格。


  ```Ruby
  # 差
  ! something

  # 好
  !something
  ```

* 范围的字面量语法中，不要添加任何空格。

    ```Ruby
    # 差
    1 .. 3
    'a' ... 'z'

    # 好
    1..3
    'a'...'z'
    ```

* 把 `when` 与 `case` 缩排在同一层级。

  ```Ruby
  # 差
  case
    when song.name == 'Misty'
      puts 'Not again!'
    when song.duration > 120
      puts 'Too long!'
    when Time.now.hour > 21
      puts "It's too late"
    else
      song.play
  end

  # 好
  case
  when song.name == 'Misty'
    puts 'Not again!'
  when song.duration > 120
    puts 'Too long!'
  when Time.now.hour > 21
    puts "It's too late"
  else
    song.play
  end
  ```
  
* 在各个方法定义之间添加空行，并且将方法分成若干合乎逻辑的段落。

  ```Ruby
  def some_method
    data = initialize(options)

    data.manipulate!

    data.result
  end

  def some_method
    result
  end
  ```

* 在各个段落之间，使用一个空行分隔。

  ```Ruby
  # 差 - 使用了两个空行
  some_method
  ```


  some_method

  # 好
  some_method

  some_method
  ```

* 在属性修饰器之后，使用一个空行分隔。

  ```Ruby
  # 差
  class Foo
    attr_reader :foo
    def foo
      # 做一些事情
    end
  end

  # 好
  class Foo
    attr_reader :foo

    def foo
      # 做一些事情
    end
  end
  ```

* 在不同缩进的代码之间，不要使用空行分隔。

  ```Ruby
  # 差
  class Foo

    def foo

      begin

        do_something do

          something

        end

      rescue

        something

      end

    end

  end

  # 好
  class Foo
    def foo
      begin
        do_something do
          something
        end
      rescue
        something
      end
    end
  end
  ```

* 避免在方法调用的最后一个参数之后添加逗号，尤其当参数没有分布在同一行时。

  ```Ruby
  # 差 - 尽管移动、新增、删除参数颇为方便，但仍不推荐这种写法
  some_method(
    size,
    count,
    color,
  )

  # 差
  some_method(size, count, color, )

  # 好
  some_method(size, count, color)
  ```

* 当给方法的参数赋予默认值时，在 `=` 前后添加空格。

  ```Ruby
  # 差
  def some_method(arg1=:default, arg2=nil, arg3=[])
    # 做一些事情
  end

  # 好
  def some_method(arg1 = :default, arg2 = nil, arg3 = [])
    # 做一些事情
  end
  ```
* 避免在非必要的情形下使用续行符 `\`。在实践中，除了字符串拼接，避免在其他任何地方使用续行。

  ```Ruby
  # 差
  result = 1 - \
           2

  # 好 - 但仍然丑到爆
  result = 1 \
           - 2

  long_string = 'First part of the long string' \
                ' and second part of the long string'
  ```

* 使用统一的风格进行多行链式方法调用。

  * **（风格 A）** 当多行链式方法调用需要另起一行继续时，将 `.` 放在第二行开头。

    ```Ruby
    # 差 - 需要查看第一行才能理解第二行在做什么
    one.two.three.
      four

    # 好 - 立刻能够明白第二行在做什么
    one.two.three
      .four
    ```

* 当方法调用参数过长时，将它们排列在多行并对齐。若对齐后长度超过行宽限制，将首个参数位置挪到下一行进行缩排也是可以接受的。

  ```Ruby
  # 初始（行太长了）
  def send_mail(source)
    Mailer.deliver(to: 'bob@example.com', from: 'us@example.com', subject: 'Important message', body: source.text)
  end

  # 差 - 双倍缩排
  def send_mail(source)
    Mailer.deliver(
        to: 'bob@example.com',
        from: 'us@example.com',
        subject: 'Important message',
        body: source.text)
  end

  # 好
  def send_mail(source)
    Mailer.deliver(to: 'bob@example.com',
                   from: 'us@example.com',
                   subject: 'Important message',
                   body: source.text)
  end

  # 好 - 普通缩排
  def send_mail(source)
    Mailer.deliver(
      to: 'bob@example.com',
      from: 'us@example.com',
      subject: 'Important message',
      body: source.text
    )
  end
  ```

* 当构建数组时，若元素跨行，应当保持对齐。

  ```Ruby
  # 差 - 没有对齐
  menu_item = ['Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
    'Baked beans', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam']

  # 好
  menu_item = [
    'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
    'Baked beans', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam'
  ]

  # 好
  menu_item =
    ['Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
     'Baked beans', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam']
  ```

* 使用 `_` 语法改善大数的数值字面量的可读性。

  ```Ruby
  # 差 - 有几个零？
  num = 1000000

  # 好 - 方便人脑理解
  num = 1_000_000
  ```

* 当数值需要前缀标识进制时，倾向使用小写字母。使用 `0o` 标识八进制，使用 `0x` 标识十六进制，使用 `0b` 标识二进制。十进制数值无需前缀（`0d`）标识。

  ```Ruby
  # 差
  num = 01234
  num = 0O1234
  num = 0X12AB
  num = 0B10101
  num = 0D1234
  num = 0d1234

  # 好 - 方便区分数值前缀与具体数字
  num = 0o1234
  num = 0x12AB
  num = 0b10101
  num = 1234
  ```


* 将单行长度控制在 80 个字符内。
* 避免行尾空格。
* 文件以空白行结束。
* 不要使用区块注释。它们不能被空白字符引导，且不如常规注释容易辨认。

  ```Ruby
  # 差
  =begin
  comment line
  another comment line
  =end

  # 好
  # comment line
  # another comment line
  ```

## 语法

* 使用 `::` 引用常量（包括类与模块）与构造器（比如 `Array()`、`Nokogiri::HTML()`）。不要使用 `::` 调用常规方法。

  ```Ruby
  # 差
  SomeClass::some_method
  some_object::some_method

  # 好
  SomeClass.some_method
  some_object.some_method
  SomeModule::SomeClass::SOME_CONST
  SomeModule::SomeClass()
  ```

* 使用 `def` 定义方法时，如果有参数则使用括号，如果无参数则省略括号。

   ```Ruby
   # 差
   def some_method()
     # 省略主体
   end

   # 好
   def some_method
     # 省略主体
   end

   # 差
   def some_method_with_parameters param1, param2
     # 省略主体
   end

   # 好
   def some_method_with_parameters(param1, param2)
     # 省略主体
   end
   ```

* 方法调用应当使用括号包裹参数，尤其是第一个参数以 `(` 开头时，比如 `f((3 + 2) + 1)`；

  ```Ruby
  x = Math.sin y  # 差
  x = Math.sin(y) # 好

  array.delete e  # 差
  array.delete(e) # 好

  temperance = Person.new 'Temperance', 30  # 差
  temperance = Person.new('Temperance', 30) # 好
  ```

  但在下述情况下可以省略括号：

  * 无参调用

    ```Ruby
    # 差
    Kernel.exit!()
    2.even?()
    fork()
    'test'.upcase()

    # 好
    Kernel.exit!
    2.even?
    fork
    'test'.upcase
    ```

  * 内部 DSL 的组成部分（比如 Rake、Rails、RSpec）

    ```Ruby
    validates(:name, presence: true)  # 差
    validates :name, presence: true   # 好
    ```

  * 具有“关键字”特性的方法

    ```Ruby
    class Person
      attr_reader(:name, :age) # 差
      attr_reader :name, :age  # 好

      # 省略主体
    end

    puts(temperance.age) # 差
    puts temperance.age  # 好
    ```

* 定义可选参数时，将可选参数放置在参数列表尾部。如果可选参数出现在列表头部，则此方法在调用时可能会产生预期之外的结果。

  ```Ruby
  # 差
  def some_method(a = 1, b = 2, c, d)
    puts "#{a}, #{b}, #{c}, #{d}"
  end

  some_method('w', 'x') # => '1, 2, w, x'
  some_method('w', 'x', 'y') # => 'w, 2, x, y'
  some_method('w', 'x', 'y', 'z') # => 'w, x, y, z'

  # 好
  def some_method(c, d, a = 1, b = 2)
    puts "#{a}, #{b}, #{c}, #{d}"
  end

  some_method('w', 'x') # => '1, 2, w, x'
  some_method('w', 'x', 'y') # => 'y, 2, w, x'
  some_method('w', 'x', 'y', 'z') # => 'y, z, w, x'
  ```

* 定义变量时，避免并行赋值。但当右值为方法调用返回值，或是与 `*` 操作符配合使用，或是交换两个变量的值，并行赋值也是可以接受的。并行赋值的可读性通常不如分开赋值。

  ```Ruby
  # 差
  a, b, c, d = 'foo', 'bar', 'baz', 'foobar'

  # 好
  a = 'foo'
  b = 'bar'
  c = 'baz'
  d = 'foobar'

  # 好 - 交换两个变量的值
  a = 'foo'
  b = 'bar'

  a, b = b, a
  puts a # => 'bar'
  puts b # => 'foo'

  # 好 - 右值为方法调用返回值
  def multi_return
    [1, 2]
  end

  first, second = multi_return

  # 好 - 与 * 操作符配合使用
  first, *list = [1, 2, 3, 4] # first => 1, list => [2, 3, 4]

  hello_array = *'Hello' # => ["Hello"]

  a = *(1..3) # => [1, 2, 3]
  ```

* 除非必要，否则避免在并行赋值时使用单字符的 `_` 变量。优先考虑前缀形式的下划线变量，而不是直接使用 `_`，因为前者可以提供一定的语义信息。但当赋值语句左侧出现带 `*` 操作符的变量时，使用 `_` 也是可以接受的。

  ```Ruby
  foo = 'one,two,three,four,five'

  # 差 - 可有可无，且无任何有用信息
  first, second, _ = foo.split(',')
  first, _, _ = foo.split(',')
  first, *_ = foo.split(',')

  # 好
  a, = foo.split(',')
  a, b, = foo.split(',')

  # 好 - 可有可无，但提供了额外信息
  first, _second = foo.split(',')
  first, _second, = foo.split(',')
  first, *_ending = foo.split(',')

  # 好 - 占位符，_ 担当最后一个元素
  *beginning, _ = foo.split(',')
  *beginning, something, _ = foo.split(',')
  ```

* 永远不要使用 `for`， 除非你很清楚为什么。大部分情况下，你应该使用迭代器。`for` 是由 `each` 实现的，所以你绕弯了。另外，`for` 没有引入一个新的作用域 (`each` 有），因此在它内部定义的变量在外部仍是可见的。

  ```Ruby
  arr = [1, 2, 3]

  # 差
  for elem in arr do
    puts elem
  end

  # 注意，elem 可在 for 循环外部被访问
  elem # => 3

  # 好
  arr.each { |elem| puts elem }

  # 注意，elem 不可在 each 块外部被访问
  elem # => NameError: undefined local variable or method `elem'
  ```

* 永远不要在多行 `if`/`unless` 中使用 `then`。

  ```Ruby
  # 差
  if some_condition then
    # 省略主体
  end

  # 好
  if some_condition
    # 省略主体
  end
  ```

* 在多行 `if/unless` 中，总是把条件表达式与 `if/unless` 放置在同一行。

  ```Ruby
  # 差
  if
    some_condition
    do_something
    do_something_else
  end

  # 好
  if some_condition
    do_something
    do_something_else
  end
  ```

* 倾向使用三元操作符（`?:`）而不是 `if/then/else/end` 结构。前者更为常见且简练。


  ```Ruby
  # 差
  result = if some_condition then something else something_else end

  # 好
  result = some_condition ? something : something_else
  ```

* 
  三元操作符的每个分支只写一个表达式。即不要嵌套三元操作符。嵌套情况请使用 `if/else` 结构。


  ```Ruby
  # 差
  some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

  # 好
  if some_condition
    nested_condition ? nested_something : nested_something_else
  else
    something_else
  end
  ```

* 永远不要使用 `if x; ...`。使用三元操作符来替代。


  ```Ruby
  # 差
  result = if some_condition; something else something_else end

  # 好
  result = some_condition ? something : something_else
  ```

* 利用“`if` 与 `case` 是表达式”的这个特性。


  ```Ruby
  # 差
  if condition
    result = x
  else
    result = y
  end

  # 好
  result =
    if condition
      x
    else
      y
    end
  ```

* 在 `case` 表达式中，单行情况使用 `when x then ...` 语法。另一种语法 `when x: ...` 在 Ruby 1.9 之后被移除了。


* 不要使用 `when x; ...` 语法。参考前一条规则。


* 使用 `!` 而不是 `not`。


  ```Ruby
  # 差 - 因为操作符的优先级，这里必须使用括号
  x = (not something)

  # 好
  x = !something
  ```

* 避免使用 `!!`。


  `!!` 会将表达式结果转换为布尔值，但对于流程控制的表达式通常并不需要如此显式的转换过程。如果需要做 `nil` 检查，那么调用对象的 `nil?` 方法。

  ```Ruby
  # 差
  x = 'test'
  # 令人费解的 nil 检查
  if !!x
    # 省略主体
  end

  # 好
  x = 'test'
  if x
    # 省略主体
  end
  ```

* 永远不要使用 `and` 与 `or` 关键字。使用 `&&` 与 `||` 来替代。


  ```Ruby
  # 差
  # 布尔表达式
  ok = got_needed_arguments and arguments_are_valid

  # 流程控制
  document.save or fail(RuntimeError, "Failed to save document!")

  # 好
  # 布尔表达式
  ok = got_needed_arguments && arguments_are_valid

  # 流程控制
  fail(RuntimeError, "Failed to save document!") unless document.save

  # 流程控制
  document.save || fail(RuntimeError, "Failed to save document!")

  ```

* 避免使用多行三元操作符（`?:`）。使用 `if`/`unless` 来替代。


* 对于单行主体，倾向使用 `if`/`unless` 修饰语法。另一种方法是使用流程控制 `&&`/`||`。


  ```Ruby
  # 差
  if some_condition
    do_something
  end

  # 好
  do_something if some_condition

  # 好 - 使用流程控制
  some_condition && do_something
  ```

* 避免在多行区块后使用 `if`/`unless` 修饰语法。


  ```Ruby
  # 差
  10.times do
    # 省略多行主体
  end if some_condition

  # 好
  if some_condition
    10.times do
      # 省略多行主体
    end
  end
  ```

* 避免使用嵌套 `if`/`unless`/`while`/`until` 修饰语法。适当情况下，使用 `&&`/`||` 来替代。


  ```Ruby
  # 差
  do_something if other_condition if some_condition

  # 好
  do_something if some_condition && other_condition
  ```

* 对于否定条件，倾向使用 `unless` 而不是 `if`（或是使用流程控制 `||`）。


  ```Ruby
  # 差
  do_something if !some_condition

  # 差
  do_something if not some_condition

  # 好
  do_something unless some_condition

  # 好
  some_condition || do_something
  ```

* 不要使用 `unless` 与 `else` 的组合。将它们改写成肯定条件。


  ```Ruby
  # 差
  unless success?
    puts 'failure'
  else
    puts 'success'
  end

  # 好
  if success?
    puts 'success'
  else
    puts 'failure'
  end
  ```

* 不要使用括号包裹流程控制中的条件表达式。




  ```Ruby
  # 差
  if (x > 10)
    # 省略主体
  end

  # 好
  if x > 10
    # 省略主体
  end
  ```

  这个规则的一个例外是[条件表达式中的安全赋值](#safe-assignment-in-condition)。

* 在多行 `while/until` 中，不要使用 `while/until condition do`。


  ```Ruby
  # 差
  while x > 5 do
    # 省略主体
  end

  until x > 5 do
    # 省略主体
  end

  # 好
  while x > 5
    # 省略主体
  end

  until x > 5
    # 省略主体
  end
  ```

* 对于单行主体，倾向使用 `while/until` 修饰语法。


  ```Ruby
  # 差
  while some_condition
    do_something
  end

  # 好
  do_something while some_condition
  ```

* 对于否定条件，倾向使用 `until` 而不是 `while`。


  ```Ruby
  # 差
  do_something while !some_condition

  # 好
  do_something until some_condition
  ```

* 对于无限循环，使用 `Kernel#loop` 而不是 `while/until`。


    ​```ruby
    # 差
    while true
      do_something
    end
    
    until false
      do_something
    end
    
    # 好
    loop do
      do_something
    end
    ​```

* 对于后置条件循环语句，倾向使用 `Kernel#loop` 与 `break` 的组合，而不是 `begin/end/until` 或 `begin/end/while`。


  ```Ruby
  # 差
  begin
    puts val
    val += 1
  end while val < 0

  # 好
  loop do
    puts val
    val += 1
    break unless val < 0
  end
  ```

* 对于可选参数的哈希，省略其外围的花括号。


  ```Ruby
  # 差
  user.set({ name: 'John', age: 45, permissions: { read: true } })

  # 好
  user.set(name: 'John', age: 45, permissions: { read: true })
  ```

* 对于 DSL 的内部方法调用，同时省略其外围的圆括号与花括号。


  ```Ruby
  class Person < ActiveRecord::Base
    # 差
    validates(:name, { presence: true, length: { within: 1..10 } })

    # 好
    validates :name, presence: true, length: { within: 1..10 }
  end
  ```

* 当被调用方法是当前区块中唯一操作时，倾向使用简短的传参语法。


  ```Ruby
  # 差
  names.map { |name| name.upcase }

  # 好
  names.map(&:upcase)
  ```

* 对于单行主体，倾向使用 `{...}` 而不是 `do...end`。对于多行主体，避免使用 `{...}`。对于“流程控制”或“方法定义”（比如 Rakefile、其他 DSL 构成片段），总是使用 `do...end`。避免在链式方法调用中使用 `do...end`。


  ```Ruby
  names = %w[Bozhidar Steve Sarah]

  # 差
  names.each do |name|
    puts name
  end

  # 好
  names.each { |name| puts name }

  # 差
  names.select do |name|
    name.start_with?('S')
  end.map { |name| name.upcase }

  # 好
  names.select { |name| name.start_with?('S') }.map(&:upcase)
  ```

  某些人可能会争论在多行链式方法调用时使用 `{...}` 看起来还可以。但他们应该扪心自问——这样的代码真的可读吗？难道不能把区块内容提取出来放到小巧的方法里吗？

* 优先考虑使用显式区块参数，以避免某些情况下通过创建区块的手法来传递参数给其他区块。此规则对性能有所影响，因为区块会被转换为 `Proc` 对象。


  ```Ruby
  require 'tempfile'

  # 差
  def with_tmp_dir
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) { |dir| yield dir }  # 通过创建区块的手法来传递参数
    end
  end

  # 好
  def with_tmp_dir(&block)
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir, &block)
    end
  end

  with_tmp_dir do |dir|
    puts "dir is accessible as a parameter and pwd is set: #{dir}"
  end
  ```

* 避免在不需要流程控制的情况下使用 `return`。


  ```Ruby
  # 差
  def some_method(some_arr)
    return some_arr.size
  end

  # 好
  def some_method(some_arr)
    some_arr.size
  end
  ```

* 避免在不需要的情况下使用 `self`。（只有在调用 `self` 的修改器、以保留字命名的方法、重载的运算符时才需要）


  ```Ruby
  # 差
  def ready?
    if self.last_reviewed_at > self.last_updated_at
      self.worker.update(self.content, self.options)
      self.status = :in_progress
    end
    self.status == :verified
  end

  # 好
  def ready?
    if last_reviewed_at > last_updated_at
      worker.update(content, options)
      self.status = :in_progress
    end
    status == :verified
  end
  ```

* 避免局部变量遮蔽方法调用，除非它们具有相同效果。


  ```Ruby
  class Foo
    attr_accessor :options

    # 勉强可以
    def initialize(options)
      self.options = options
      # 此处 self.options 与 options 具有相同效果
    end

    # 差
    def do_something(options = {})
      unless options[:when] == :later
        output(self.options[:message])
      end
    end

    # 好
    def do_something(params = {})
      unless params[:when] == :later
        output(options[:message])
      end
    end
  end
  ```

* 不要在条件表达式中使用 `=`（赋值语句）的返回值，除非赋值语句包裹在括号之中。这种惯用法被称作**条件表达式中的安全赋值**。


  ```Ruby
  # 差 - 会出现警告
  if v = array.grep(/foo/)
    do_something(v)
    ...
  end

  # 好 - 尽管 Ruby 解释器仍会出现警告，但 RuboCop 不会
  if (v = array.grep(/foo/))
    do_something(v)
    ...
  end

  # 好
  v = array.grep(/foo/)
  if v
    do_something(v)
    ...
  end
  ```

* 优先考虑简短的自我赋值语法。


  ```Ruby
  # 差
  x = x + y
  x = x * y
  x = x**y
  x = x / y
  x = x || y
  x = x && y

  # 好
  x += y
  x *= y
  x **= y
  x /= y
  x ||= y
  x &&= y
  ```

* 当变量尚未初始化时，使用 `||=` 对其进行初始化。


  ```Ruby
  # 差
  name = name ? name : 'Bozhidar'

  # 差
  name = 'Bozhidar' unless name

  # 好 - 当且仅当 name 为 nil 或 false 时，设置 name 的值为 'Bozhidar'
  name ||= 'Bozhidar'
  ```

* 不要使用 `||=` 对布尔变量进行初始化。


  ```Ruby
  # 差 - 设置 enabled 的值为 true，即使其原本的值是 false
  enabled ||= true

  # 好
  enabled = true if enabled.nil?
  ```

* 使用 `&&=` 预先检查变量是否存在，如果存在，则做相应动作。使用 `&&=` 语法可以省去 `if` 检查。


  ```Ruby
  # 差
  if something
    something = something.downcase
  end

  # 差
  something = something ? something.downcase : nil

  # 勉强可以
  something = something.downcase if something

  # 好
  something = something && something.downcase

  # 更好
  something &&= something.downcase
  ```

* 避免使用 `case` 语句等价操作符 `===`。从名称可知，这是 `case` 语句隐式使用的操作符，在 `case` 语句外的场合中使用，会产生难以理解的代码。


  ```Ruby
  # 差
  Array === something
  (1..100) === 7
  /something/ === some_string

  # 好
  something.is_a?(Array)
  (1..100).include?(7)
  some_string =~ /something/
  ```

* 能使用 `==` 就不要使用 `eql?`。提供更加严格比较的 `eql?` 在实践中极少使用。


  ```Ruby
  # 差 - 对于字符串，eql? 与 == 具有相同效果
  'ruby'.eql? some_str

  # 好
  'ruby' == some_str
  1.0.eql? x # 当需要区别 Fixnum 1 与 Float 1.0 时，eql? 是具有意义的
  ```

* 避免使用 Perl 风格的特殊变量（比如 `$:`、`$;` 等）。它们看起来非常神秘，但除了单行脚本，其他情况并不鼓励使用。建议使用 `English` 程序库提供的友好别名。


  ```Ruby
  # 差
  $:.unshift File.dirname(__FILE__)

  # 好
  require 'English'
  $LOAD_PATH.unshift File.dirname(__FILE__)
  ```

* 永远不要在方法名与左括号之间添加空格。


  ```Ruby
  # 差
  f (3 + 2) + 1

  # 好
  f(3 + 2) + 1
  ```

* 运行 Ruby 解释器时，总是开启 `-w` 选项来。如果你忘了某个上述某个规则，它就会警告你！


* 不要在方法中嵌套定义方法，使用 lambda 方法来替代。 嵌套定义产生的方法，事实上和外围方法处于同一作用域（比如类作用域）。此外，“嵌套方法”会在定义它的外围方法每次调用时被重新定义。


  ```Ruby
  # 差
  def foo(x)
    def bar(y)
      # 省略主体
    end

    bar(x)
  end

  # 好 - 作用同前，但 bar 不会在 foo 每次调用时被重新定义
  def bar(y)
    # 省略主体
  end

  def foo(x)
    bar(x)
  end

  # 好
  def foo(x)
    bar = ->(y) { ... }
    bar.call(x)
  end
  ```

* 对于单行区块，使用新的 lambda 字面量定义语法。对于多行区块，使用 `lambda` 定义语法。


  ```Ruby
  # 差
  l = lambda { |a, b| a + b }
  l.call(1, 2)

  # 好 - 但看起来怪怪的
  l = ->(a, b) do
    tmp = a * 7
    tmp * b / 50
  end

  # 好
  l = ->(a, b) { a + b }
  l.call(1, 2)

  l = lambda do |a, b|
    tmp = a * 7
    tmp * b / 50
  end
  ```

* 定义 lambda 方法时，如果有参数则使用括号。


  ```Ruby
  # 差
  l = ->x, y { something(x, y) }

  # 好
  l = ->(x, y) { something(x, y) }
  ```

* 定义 lambda 方法时，如果无参数则省略括号。


  ```Ruby
  # 差
  l = ->() { something }

  # 好
  l = -> { something }
  ```

* 倾向使用 `proc` 而不是 `Proc.new`。


  ```Ruby
  # 差
  p = Proc.new { |n| puts n }

  # 好
  p = proc { |n| puts n }
  ```

* 对于 lambda 方法或代码块，倾向使用 `proc.call()` 而不是 `proc[]` 或 `proc.()`。


  ```Ruby
  # 差 - 看上去像是枚举器的存取操作
  l = ->(v) { puts v }
  l[1]

  # 差 - 极少见的调用语法
  l = ->(v) { puts v }
  l.(1)

  # 好
  l = ->(v) { puts v }
  l.call(1)
  ```

* 未被使用的区块参数或局部变量，添加 `_` 前缀或直接使用 `_`（尽管表意性略差）。这种做法可以抑制 Ruby 解释器或 RuboCop 等工具发出“变量尚未使用”的警告。


  ```Ruby
  # 差
  result = hash.map { |k, v| v + 1 }

  def something(x)
    unused_var, used_var = something_else(x)
    # ...
  end

  # 好
  result = hash.map { |_k, v| v + 1 }

  def something(x)
    _unused_var, used_var = something_else(x)
    # ...
  end

  # 好
  result = hash.map { |_, v| v + 1 }

  def something(x)
    _, used_var = something_else(x)
    # ...
  end
  ```

* 使用 `$stdout/$stderr/$stdin` 而不是 `STDOUT/STDERR/STDIN`。`STDOUT/STDERR/STDIN` 是常量，尽管在 Ruby 中允许给常量重新赋值（可能是重定向某些流），但解释器会发出警告。


* 使用 `warn` 而不是 `$stderr.puts`。除了更加简练清晰外，`warn` 允许你在需要时通过设置解释器选项（使用 `-W0` 将警告级别设置为 0）来抑制警告。


* 倾向使用 `sprintf` 或其别名 `format` 而不是相当晦涩的 `String#%` 方法。


  ```Ruby
  # 差
  '%d %d' % [20, 10]
  # => '20 10'

  # 好
  sprintf('%d %d', 20, 10)
  # => '20 10'

  # 好
  sprintf('%{first} %{second}', first: 20, second: 10)
  # => '20 10'

  format('%d %d', 20, 10)
  # => '20 10'

  # 好
  format('%{first} %{second}', first: 20, second: 10)
  # => '20 10'
  ```

* 倾向使用 `Array#join` 而不是相当晦涩的带字符参数的 `Array#*` 方法。


  ```Ruby
  # 差
  %w[one two three] * ', '
  # => 'one, two, three'

  # 好
  %w[one two three].join(', ')
  # => 'one, two, three'
  ```

* 当你希望处理的变量类型是数组，但不太确定其是否真的是数组时，通过使用 `Array()` 来替代显式的数组类型检查与转换。



  ```Ruby
  # 差
  paths = [paths] unless paths.is_a? Array
  paths.each { |path| do_something(path) }

  # 差 - 总是构建新的数组对象
  [*paths].each { |path| do_something(path) }

  # 好
  Array(paths).each { |path| do_something(path) }
  ```

* 通过使用范围或 `Comparable#between?` 来替代复杂的比较逻辑。


  ```Ruby
  # 差
  do_something if x >= 1000 && x <= 2000

  # 好
  do_something if (1000..2000).include?(x)

  # 好
  do_something if x.between?(1000, 2000)
  ```

* 倾向使用谓词方法而不是 `==` 操作符。但数值比较除外。


  ```Ruby
  # 差
  if x % 2 == 0
  end

  if x % 2 == 1
  end

  if x == nil
  end

  # 好
  if x.even?
  end

  if x.odd?
  end

  if x.nil?
  end

  if x.zero?
  end

  if x == 0
  end
  ```

* 不做显式的 `non-nil` 检查，除非检查对象是布尔变量。


    ​```ruby
    # 差
    do_something if !something.nil?
    do_something if something != nil
    
    # 好
    do_something if something
    
    # 好 - 检查对象是布尔变量
    def value_set?
      !@some_boolean.nil?
    end
    ​```

* 避免使用 `BEGIN` 区块。


* 永远不要使用 `END` 区块。使用 `Kernel#at_exit` 来替代。


  ```ruby
  # 差
  END { puts 'Goodbye!' }

  # 好
  at_exit { puts 'Goodbye!' }
  ```

* 避免使用 flip-flops 操作符。


* 流程控制中，避免使用嵌套条件。


  倾向使用防御从句进行非法数据断言。防御从句是指处于方法顶部的条件语句，其能尽早地退出方法。

  ```Ruby
  # 差
  def compute_thing(thing)
    if thing[:foo]
      update_with_bar(thing[:foo])
      if thing[:foo][:bar]
        partial_compute(thing)
      else
        re_compute(thing)
      end
    end
  end

  # 好
  def compute_thing(thing)
    return unless thing[:foo]
    update_with_bar(thing[:foo])
    return re_compute(thing) unless thing[:foo][:bar]
    partial_compute(thing)
  end
  ```

  循环中，倾向使用 `next` 而不是条件区块。

  ```Ruby
  # 差
  [0, 1, 2, 3].each do |item|
    if item > 1
      puts item
    end
  end

  # 好
  [0, 1, 2, 3].each do |item|
    next unless item > 1
    puts item
  end
  ```

* 倾向使用 `map` 而不是 `collect`，`find` 而不是 `detect`，`select` 而不是 `find_all`，`reduce` 而不是 `inject` 以及 `size` 而不是 `length`。这不是一个硬性要求，如果使用别名可以增强可读性，使用它也没关系。这些别名方法继承自 Smalltalk 语言，但在别的语言并不通用。鼓励使用 `select` 而不是 `find_all` 的理由是前者与 `reject` 搭配起来一目了然。


* 不要使用 `count` 作为 `size` 的替代方案。除了 `Array` 外，其他 `Enumerable` 对象都需要通过枚举整个集合才可以确定数目。


  ```Ruby
  # 差
  some_hash.count

  # 好
  some_hash.size
  ```

* 倾向使用 `flat_map` 而不是 `map + flatten` 的组合。此规则并不适用于深度超过 2 层的数组。举例来说，如果 `users.first.songs == ['a', ['b','c']]` 成立，则使用 `map + flatten` 的组合而不是 `flat_map`。`flat_map` 只能平坦化一个层级，而 `flatten` 能够平坦化任意多个层级。


  ```Ruby
  # 差
  all_songs = users.map(&:songs).flatten.uniq

  # 好
  all_songs = users.flat_map(&:songs).uniq
  ```

* 倾向使用 `reverse_each` 而不是 `reverse.each`，因为某些混入 `Enumerable` 模块的类可能会提供 `reverse_each` 的高效版本。即使这些类没有提供专门特化的版本，继承自 `Enumerable` 的通用版本至少能保证性能与 `reverse.each` 相当。


  ```Ruby
  # 差
  array.reverse.each { ... }

  # 好
  array.reverse_each { ... }
  ```

## 命名

> 程序设计的真正难题是替事物命名及使缓存失效。<br>
> ——Phil Karlton

* 标识符使用英文命名。


  ```Ruby
  # 差 - 标识符使用非 ASCII 字符
  заплата = 1_000

  # 差 - 标识符使用拉丁文写法的保加利亚单词
  zaplata = 1_000

  # 好
  salary = 1_000
  ```

* 符号、方法、变量使用蛇底式小写（`snake_case`）。


  ```Ruby
  # 差
  :'some symbol'
  :SomeSymbol
  :someSymbol

  someVar = 5
  var_10 = 10

  def someMethod
    ...
  end

  def SomeMethod
   ...
  end

  # 好
  :some_symbol

  some_var = 5
  var10 = 10

  def some_method
    ...
  end
  ```

* 给符号、方法、变量命名时，避免分隔字母与数字。


  ```Ruby
  # 差
  :some_sym_1

  some_var_1 = 1

  def some_method_1
    # 做一些事情
  end

  # 好
  :some_sym1

  some_var1 = 1

  def some_method1
    # 做一些事情
  end
  ```

* 类与模块使用驼峰式大小写（`CamelCase`）。（HTTP、RFC、XML 等首字母缩写应该仍旧保持大写形式）


  ```Ruby
  # 差
  class Someclass
    ...
  end

  class Some_Class
    ...
  end

  class SomeXml
    ...
  end

  class XmlSomething
    ...
  end

  # 好
  class SomeClass
    ...
  end

  class SomeXML
    ...
  end

  class XMLSomething
    ...
  end
  ```

* 文件名使用蛇底式小写，如 `hello_world.rb`。


* 目录名使用蛇底式小写，如 `lib/hello_world/hello_world.rb`。


* 尽量使一个源文件中只有一个类或模块。文件名就是类名或模块名，但使用蛇底式小写而不是驼峰式大小写。


* 其他常量使用尖叫蛇底式大写（SCREAMING_SNAKE_CASE）。


  ```Ruby
  # 差
  SomeConst = 5

  # 好
  SOME_CONST = 5
  ```

* 谓词方法（返回布尔值的方法）的名字应当以问号结尾。（比如 `Array#empty?`）。不返回布尔值的方法不应以问号结尾。


* 谓词方法的名字应当避免使用 `is`、`does`、`can` 等助动词作为前缀。这些助动词在实际场景中显得冗余，且与标准库的命名习惯（比如 `empty?`、`include?`）很不一致。


  ```Ruby
  # 差
  class Person
    def is_tall?
      true
    end

    def can_play_basketball?
      false
    end

    def does_like_candy?
      true
    end
  end

  # 好
  class Person
    def tall?
      true
    end

    def basketball_player?
      false
    end

    def likes_candy?
      true
    end
  end
  ```

* 具有潜在**危险性**的方法，当其存在对应安全版本的方法时，其名字应当以惊叹号结尾。（比如修改 `self` 或参数值的方法、相对 `exit` 方法不会在退出时运行 finalizers 执行清理工作的 `exit!` 方法等）


  ```Ruby
  # 差 - 没有对应安全版本的方法
  class Person
    def update!
    end
  end

  # 好
  class Person
    def update
    end
  end

  # 好
  class Person
    def update!
    end

    def update
    end
  end
  ```

* 尽量根据危险方法来定义对应安全版本的方法。


  ```Ruby
  class Array
    def flatten_once!
      res = []

      each do |e|
        [*e].each { |f| res << f }
      end

      replace(res)
    end

    def flatten_once
      dup.flatten_once!
    end
  end
  ```

* 当定义二元操作符时，将参数命名为 `other`（`<<` 与 `[]` 例外，因为其语义与此不同）。


  ```Ruby
  def +(other)
    # 省略主体
  end
  ```

## 注释

> 良好的代码自身就是最佳的文档。当你要添加一个注释时，扪心自问，“如何改善代码让它不需要注释？” 改善代码，再写相应文档使之更清楚。<br>
> ——Steve McConnell

* 编写让人一目了然的代码然后忽略这一节的其它部分。我是认真的！


* 使用英文编写注释。


* 前导 `#` 与注释文本之间应当添加一个空格。


* 注释超过一个单词时，句首字母应当大写，并在语句停顿或结尾处使用标点符号。句号后添加[一个空格](http://en.wikipedia.org/wiki/Sentence_spacing)。


* 避免无谓的注释。


  ```Ruby
  # 差
  counter += 1 # Increments counter by one.
  ```

* 及时更新注释。过时的注释比没有注释还要糟糕。


> 好的代码就像是好的笑话 —— 它不需要解释。<br>
> ——Russ Olsen

* 避免替烂代码编写注释。重构它们使其变得一目了然。（要么做，要么不做，不要只是试试看。——Yoda）


### 注解

* 注解应该直接写在相关代码之前那行。


* 注解关键字后面，跟着一个冒号及空格，接着是描述问题的文本。


* 如果需要用多行来描述问题，后续行要放在 `#` 后面并缩排两个空格。


  ```Ruby
  def bar
    # FIXME: This has crashed occasionally since v3.2.1. It may
    #   be related to the BarBazUtil upgrade.
    baz(:quux)
  end
  ```

* 当问题是显而易见时，任何文档都是多余的，注解应当放在有问题的那行末尾且不带任何多余说明。这个用法应该算是例外而不是规则。


  ```Ruby
  def bar
    sleep 100 # OPTIMIZE
  end
  ```

* 使用 `TODO` 标记应当加入的特征与功能。


* 使用 `FIXME` 标记需要修复的代码。


* 使用 `OPTIMIZE` 标记可能引发性能问题的低效代码。


* 使用 `HACK` 标记代码异味，即那些应当被重构的可疑编码习惯。


* 使用 `REVIEW` 标记需要确认与编码意图是否一致的可疑代码。比如，`REVIEW: Are we sure this is how the client does X currently?`。


* 适当情况下，可以自行定制其他注解关键字，但别忘记在项目的 `README` 或类似文档中予以说明。


### Magic Comments

* Place magic comments above all code and documentation. Magic comments should only go below shebangs if they are needed in your source file.


  ```Ruby
  # good
  # frozen_string_literal: true
  # Some documentation about Person
  class Person
  end

  # bad
  # Some documentation about Person
  # frozen_string_literal: true
  class Person
  end
  ```

  ```Ruby
  # good
  #!/usr/bin/env ruby
  # frozen_string_literal: true
  App.parse(ARGV)

  # bad
  # frozen_string_literal: true
  #!/usr/bin/env ruby
  App.parse(ARGV)
  ```

* Use one magic comment per line if you need multiple.


  ```Ruby
  # good
  # frozen_string_literal: true
  # encoding: ascii-8bit

  # bad
  # -*- frozen_string_literal: true; encoding: ascii-8bit -*-
  ```

* Separate magic comments from code and documentation with a blank line.


  ```Ruby
  # good
  # frozen_string_literal: true

  # Some documentation for Person
  class Person
    # Some code
  end

  # bad
  # frozen_string_literal: true
  # Some documentation for Person
  class Person
    # Some code
  end
  ```

## 类与模块

* 在类定义中，使用一致的结构。


  ```Ruby
  class Person
    # 首先是 extend 与 include
    extend SomeModule
    include AnotherModule

    # 内部类
    CustomError = Class.new(StandardError)

    # 接着是常量
    SOME_CONSTANT = 20

    # 接下来是属性宏
    attr_reader :name

    # 跟着是其他宏（如果有的话）
    validates :name

    # 公开的类方法接在下一行
    def self.some_method
    end

    # 初始化方法在类方法和实例方法之间
    def initialize
    end

    # 跟着是公开的实例方法
    def some_method
    end

    # 受保护及私有的方法等放在接近结尾的地方
    protected

    def some_protected_method
    end

    private

    def some_private_method
    end
  end
  ```

* 在混入多个模块时，倾向使用多行语法。


  ```Ruby
  # 差
  class Person
    include Foo, Bar
  end

  # 好
  class Person
    include Foo
    include Bar
  end
  ```

* 如果嵌套类数目较多，进而导致外围类定义较长，则将它们从外围类中提取出来，分别放置在单独的以嵌套类命名的文件中，并将文件归类至以外围类命名的文件夹下。


  ```Ruby
  # 差

  # foo.rb
  class Foo
    class Bar
      # 定义 30 多个方法
    end

    class Car
      # 定义 20 多个方法
    end

    # 定义 30 多个方法
  end

  # 好

  # foo.rb
  class Foo
    # 定义 30 多个方法
  end

  # foo/bar.rb
  class Foo
    class Bar
      # 定义 30 多个方法
    end
  end

  # foo/car.rb
  class Foo
    class Car
      # 定义 20 多个方法
    end
  end
  ```

* 定义只有类方法的数据类型时，倾向使用模块而不是类。只有当需要实例化时才使用类。


  ```Ruby
  # 差
  class SomeClass
    def self.some_method
      # 省略主体
    end

    def self.some_other_method
      # 省略主体
    end
  end

  # 好
  module SomeModule
    module_function

    def some_method
      # 省略主体
    end

    def some_other_method
      # 省略主体
    end
  end
  ```

* 当你想将模块的实例方法变成类方法时，倾向使用 `module_function` 而不是 `extend self`。


  ```Ruby
  # 差
  module Utilities
    extend self

    def parse_something(string)
      # 做一些事情
    end

    def other_utility_method(number, string)
      # 做一些事情
    end
  end

  # 好
  module Utilities
    module_function

    def parse_something(string)
      # 做一些事情
    end

    def other_utility_method(number, string)
      # 做一些事情
    end
  end
  ```

* 当设计类的层次结构时，确保它们符合[里式替换原则](http://en.wikipedia.org/wiki/Liskov_substitution_principle)。


* 让你的类尽量满足 [SOLID 原则](http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)) 。


* 总是替那些用以表示领域模型的类提供一个适当的 `to_s` 方法。


  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    def to_s
      "#{@first_name} #{@last_name}"
    end
  end
  ```

* 使用 `attr` 系列方法来定义琐碎的存取器或修改器。


  ```Ruby
  # 差
  class Person
    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    def first_name
      @first_name
    end

    def last_name
      @last_name
    end
  end

  # 好
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end
  ```

* 对于访问器方法，避免使用 `get_` 作为名字前缀；对于更改器方法，避免使用 `set_` 作为名字前缀。Ruby 语言中，通常使用 `attr_name` 作为访问器的方法名，使用 `attr_name=` 作为更改器的方法名。


  ```Ruby
  # 差
  class Person
    def get_name
      "#{@first_name} #{@last_name}"
    end

    def set_name(name)
      @first_name, @last_name = name.split(' ')
    end
  end

  # 好
  class Person
    def name
      "#{@first_name} #{@last_name}"
    end

    def name=(name)
      @first_name, @last_name = name.split(' ')
    end
  end
  ```

* 避免使用 `attr`。使用 `attr_reader` 与 `attr_accessor` 来替代。


  ```Ruby
  # 差 - 创建单个存取方法（此方法在 Ruby 1.9 之后被移除了）
  attr :something, true
  attr :one, :two, :three # 类似于 attr_reader

  # 好
  attr_accessor :something
  attr_reader :one, :two, :three
  ```

* 优先考虑使用 `Struct.new`。它替你定义了那些琐碎的访问器、构造器及比较操作符。


  ```Ruby
  # 好
  class Person
    attr_accessor :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end

  # 更好
  Person = Struct.new(:first_name, :last_name) do
  end
  ```

* 不要扩展 `Struct.new` 实例化后的对象。对它进行扩展不但引入了毫无意义的类层次，而且在此文件被多次引入时可能会产生奇怪的错误。


  ```Ruby
  # 差
  class Person < Struct.new(:first_name, :last_name)
  end

  # 好
  Person = Struct.new(:first_name, :last_name)
  ```

* 优先考虑通过工厂方法的方式创建某些具有特定意义的实例对象。


  ```Ruby
  class Person
    def self.create(options_hash)
      # 省略主体
    end
  end
  ```

* 倾向使用[鸭子类型](https://en.wikipedia.org/wiki/Duck_typing)而不是继承。


  ```Ruby
  # 差
  class Animal
    # 抽象方法
    def speak
    end
  end

  # 继承父类
  class Duck < Animal
    def speak
      puts 'Quack! Quack'
    end
  end

  # 继承父类
  class Dog < Animal
    def speak
      puts 'Bau! Bau!'
    end
  end

  # 好
  class Duck
    def speak
      puts 'Quack! Quack'
    end
  end

  class Dog
    def speak
      puts 'Bau! Bau!'
    end
  end
  ```

* 避免使用类变量（`@@`）。类变量在继承方面存在令人生厌的行为。


  ```Ruby
  class Parent
    @@class_var = 'parent'

    def self.print_class_var
      puts @@class_var
    end
  end

  class Child < Parent
    @@class_var = 'child'
  end

  Parent.print_class_var # => 此处打印的结果为 'child'
  ```

  如你所见，在类的层次结构中所有类都会共享同一类变量。通常情况下，倾向使用类实例变量而不是类变量。

* 根据方法的目的与用途设置适当的可见级别（`private`、`protected`）。不要什么都不做就把所有方法设置为 `public`（默认值）。毕竟我们写的是 **Ruby** 而不是 **Python**。


* 把 `public`、`protected`、`private` 与其作用的方法缩排在同一层级。且在其上下各留一行以强调此可见级别作用于之后的所有方法。

  ```Ruby
  class SomeClass
    def public_method
      # ...
    end

    private

    def private_method
      # ...
    end

    def another_private_method
      # ...
    end
  end
  ```

* 使用 `def self.method` 定义类方法。这种做法使得在代码重构时，即使修改了类名也无需做多次修改。

  ```Ruby
  class TestClass
    # 差
    def TestClass.some_method
      # 省略主体
    end

    # 好
    def self.some_other_method
      # 省略主体
    end

    # 在需要定义多个类方法时，另一种便捷写法
    class << self
      def first_method
        # 省略主体
      end

      def second_method_etc
        # 省略主体
      end
    end
  end
  ```

* 在类的词法作用域中定义方法别名时，倾向使用 `alias`。因为定义期间 `alias` 与 `self` 指向的都是词法作用域，除非明确说明，否则该别名所引用的方法不会在运行期间被改变，或是在任何子类中被修改。

  ```Ruby
  class Westerner
    def first_name
      @names.first
    end

    alias given_name first_name
  end
  ```

  因为 `alias` 与 `def` 一样都是关键字，倾向使用裸字而不是符号或字符串。也就是说，使用 `alias foo bar` 而不是 `alias :foo :bar`。

  另外需要了解 Ruby 是如何处理别名和继承的：别名所引用的原始方法是在定义期间被指定的，而不是运行期间。

  ```Ruby
  class Fugitive < Westerner
    def first_name
      'Nobody'
    end
  end
  ```

  在这个例子中，`Fugitive#given_name` 仍然调用原先的 `Westerner#first_name` 方法，而不是 `Fugitive#first_name`。如果想要覆写 `Fugitive#given_name`，必须在子类中重新定义。

  ```Ruby
  class Fugitive < Westerner
    def first_name
      'Nobody'
    end

    alias given_name first_name
  end
  ```

* 在运行期间定义模块方法、类方法、单件方法的别名时，总是使用 `alias_method`。在上述情况下，使用 `alias` 可能会导致预期之外的结果。


  ```Ruby
  module Mononymous
    def self.included(other)
      other.class_eval { alias_method :full_name, :given_name }
    end
  end

  class Sting < Westerner
    include Mononymous
  end
  ```

* 在模块方法，或是类方法内部调用自身其他方法时，通常省略模块名/类名/`self`。


  ```Ruby
  class TestClass
    # 差
    def self.call(param1, param2)
      TestClass.new(param1).call(param2)
    end

    # 差
    def self.call(param1, param2)
      self.new(param1).call(param2)
    end

    # 好
    def self.call(param1, param2)
      new(param1).call(param2)
    end

    # 省略其他方法
  end
  ```

## 异常

* 对于异常处理，倾向使用 `raise` 而不是 `fail`。


  ```Ruby
  # 差
  fail SomeException, 'message'

  # 好
  raise SomeException, 'message'
  ```

* 不要在带双参数形式的 `raise` 方法中显式指定 `RuntimeError`。


  ```Ruby
  # 差
  raise RuntimeError, 'message'

  # 好 - 默认就是 RuntimeError
  raise 'message'
  ```

* 倾向使用带异常类、消息的双参数形式调用 `raise` 方法，而不是使用异常的实例。


  ```Ruby
  # 差 - 并无 raise SomeException.new('message') [, backtraces] 这种调用形式
  raise SomeException.new('message')

  # 好 - 与调用形式 raise SomeException [, 'message' [, backtraces]] 保持一致
  raise SomeException, 'message'
  ```

* 永远不要从 `ensure` 区块返回。如果你显式地从 `ensure` 区块返回，那么其所在的方法会如同永远不会发生异常般的返回。事实上，异常被默默地丢弃了。


  ```Ruby
  def foo
    raise
  ensure
    return 'very bad idea'
  end
  ```

* 尽可能隐式地使用 `begin/rescue/ensure/end` 区块。


  ```Ruby
  # 差
  def foo
    begin
      # 主逻辑
    rescue
      # 异常处理逻辑
    end
  end

  # 好
  def foo
    # 主逻辑
  rescue
    # 异常处理逻辑
  end
  ```

* 通过使用 **contingency 方法**（一个由 Avdi Grimm 创造的词）来减少 `begin/rescue/ensure/end` 区块的使用。


  ```Ruby
  # 差
  begin
    something_that_might_fail
  rescue IOError
    # 处理 IOError
  end

  begin
    something_else_that_might_fail
  rescue IOError
    # 处理 IOError
  end

  # 好
  def with_io_error_handling
     yield
  rescue IOError
    # 处理 IOError
  end

  with_io_error_handling { something_that_might_fail }

  with_io_error_handling { something_else_that_might_fail }
  ```

* 
  不要抑制异常。


  ```Ruby
  # 差
  begin
    # 抛出异常
  rescue SomeError
    # 不做任何相关处理
  end

  # 差
  do_something rescue nil
  ```

* 避免使用 `rescue` 修饰语法。


  ```Ruby
  # 差 - 这里将会捕捉 StandardError 及其所有子孙类的异常
  read_file rescue handle_error($!)

  # 好 - 这里只会捕获 Errno::ENOENT 及其所有子孙类的异常
  def foo
    read_file
  rescue Errno::ENOENT => ex
    handle_error(ex)
  end
  ```

* 不要将异常处理作为流程控制使用。


  ```Ruby
  # 差
  begin
    n / d
  rescue ZeroDivisionError
    puts 'Cannot divide by 0!'
  end

  # 好
  if d.zero?
    puts 'Cannot divide by 0!'
  else
    n / d
  end
  ```

* 避免捕获 `Exception`。这种做法会同时将信号与 `exit` 方法困住，导致你必须使用 `kill -9` 来终止进程。


  ```Ruby
  # 差 - 信号与 exit 方法产生的异常会被捕获（除了 kill -9）
  begin
    exit
  rescue Exception
    puts "you didn't really want to exit, right?"
    # 处理异常
  end

  # 好 - 没有指定具体异常的 rescue 子句默认捕获 StandardError
  begin
    # 抛出异常
  rescue => e
    # 处理异常
  end

  # 好 - 指定具体异常 StandardError
  begin
    # 抛出异常
  rescue StandardError => e
    # 处理异常
  end
  ```

* 把较具体的异常放在处理链的较上层，不然它们永远不会被执行。


  ```Ruby
  # 差
  begin
    # 抛出异常
  rescue StandardError => e
    # 处理异常
  rescue IOError => e
    # 处理异常，但事实上永远不会被执行
  end

  # 好
  begin
    # 抛出异常
  rescue IOError => e
    # 处理异常
  rescue StandardError => e
    # 处理异常
  end
  ```

* 在 `ensure` 区块释放程序的外部资源。


  ```Ruby
  f = File.open('testfile')
  begin
    # .. 文件操作
  rescue
    # .. 处理异常
  ensure
    f.close if f
  end
  ```

* 在调用资源获取方法时，尽量使用具备自动清理功能的版本。


  ```Ruby
  # 差 - 需要显式关闭文件描述符
  f = File.open('testfile')
    # ...
  f.close

  # 好 - 文件描述符会被自动关闭
  File.open('testfile') do |f|
    # ...
  end
  ```

* 倾向使用标准库中的异常类而不是引入新的类型。


## 集合

* 对于数组与哈希，倾向使用字面量语法来构建实例（除非你需要给构造器传递参数）。


  ```Ruby
  # 差
  arr = Array.new
  hash = Hash.new

  # 好
  arr = []
  hash = {}
  ```

* 当创建一组元素为单词（没有空格或特殊字符）的数组时，倾向使用 `%w` 而不是 `[]`。此规则只适用于数组元素有两个或以上的时候。


  ```Ruby
  # 差
  STATES = ['draft', 'open', 'closed']

  # 好
  STATES = %w[draft open closed]
  ```

* 当创建一组符号类型的数组（且不需要保持 Ruby 1.9 兼容性）时，倾向使用 `%i`。此规则只适用于数组元素有两个或以上的时候。


  ```Ruby
  # 差
  STATES = [:draft, :open, :closed]

  # 好
  STATES = %i[draft open closed]
  ```

* 避免在数组与哈希的字面量语法的最后一个元素之后添加逗号，尤其当元素没有分布在同一行时。


  ```Ruby
  # 差 - 尽管移动、新增、删除元素颇为方便，但仍不推荐这种写法
  VALUES = [
             1001,
             2020,
             3333,
           ]

  # 差
  VALUES = [1001, 2020, 3333, ]

  # 好
  VALUES = [1001, 2020, 3333]
  ```

* 避免在数组中创造巨大的间隔。


  ```Ruby
  arr = []
  arr[100] = 1 # 现在你有一个很多 nil 的数组
  ```

* 当访问数组的首元素或尾元素时，倾向使用 `first` 或 `last` 而不是 `[0]` 或 `[-1]`。


* 当处理的对象不存在重复元素时，使用 `Set` 来替代 `Array`。`Set` 是实现了无序且无重复元素的集合类型。它兼具 `Array` 的直观操作与 `Hash` 的快速查找。


* 倾向使用符号而不是字符串作为哈希键。


  ```Ruby
  # 差
  hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

  # 好
  hash = { one: 1, two: 2, three: 3 }
  ```

* 避免使用可变对象作为哈希键。


* 当哈希键为符号时，使用 Ruby 1.9 的字面量语法。


  ```Ruby
  # 差
  hash = { :one => 1, :two => 2, :three => 3 }

  # 好
  hash = { one: 1, two: 2, three: 3 }
  ```

* 当哈希键既有符号又有字符串时，不要使用 Ruby 1.9 的字面量语法。


  ```Ruby
  # 差
  { a: 1, 'b' => 2 }

  # 好
  { :a => 1, 'b' => 2 }
  ```

* 倾向使用 `Hash#key?` 而不是 `Hash#has_key?`，使用 `Hash#value?` 而不是 `Hash#has_value?`。


  ```Ruby
  # 差
  hash.has_key?(:test)
  hash.has_value?(value)

  # 好
  hash.key?(:test)
  hash.value?(value)
  ```
* 倾向使用 `Hash#each_key` 而不是 `Hash#keys.each`，使用 `Hash#each_value` 而不是 `Hash#values.each`。


  ```Ruby
  # 差
  hash.keys.each { |k| p k }
  hash.values.each { |v| p v }
  hash.each { |k, _v| p k }
  hash.each { |_k, v| p v }

  # 好
  hash.each_key { |k| p k }
  hash.each_value { |v| p v }
  ```

* 当处理应该存在的哈希键时，使用 `Hash#fetch`。


  ```Ruby
  heroes = { batman: 'Bruce Wayne', superman: 'Clark Kent' }

  # 差 - 如果我们打错了哈希键，则难以发现这个错误
  heroes[:batman] # => 'Bruce Wayne'
  heroes[:supermann] # => nil

  # 好 - fetch 会抛出 KeyError 使这个错误显而易见
  heroes.fetch(:supermann)
  ```

* 当为哈希键的值提供默认值时，倾向使用 `Hash#fetch` 而不是自定义逻辑。


  ```Ruby
  batman = { name: 'Bruce Wayne', is_evil: false }

  # 差 - 如果仅仅使用 || 操作符，那么当值为假时，我们不会得到预期结果
  batman[:is_evil] || true # => true

  # 好 - fetch 在遇到假值时依然可以正确工作
  batman.fetch(:is_evil, true) # => false
  ```

* 当提供默认值的求值代码具有副作用或开销较大时，倾向使用 `Hash#fetch` 的区块形式。


  ```Ruby
  batman = { name: 'Bruce Wayne' }

  # 差 - 此形式会立即求值，如果调用多次，可能会影响程序的性能
  batman.fetch(:powers, obtain_batman_powers) # obtain_batman_powers 开销较大

  # 好 - 此形式会惰性求值，只有抛出 KeyError 时，才会产生开销
  batman.fetch(:powers) { obtain_batman_powers }
  ```

* 当需要一次性从哈希中获取多个键的值时，使用 `Hash#values_at`。


  ```Ruby
  # 差
  email = data['email']
  username = data['nickname']

  # 好
  email, username = data.values_at('email', 'nickname')
  ```

* 利用“Ruby 1.9 之后的哈希是有序的”的这个特性。


* 当遍历集合时，不要改动它。


* 当访问集合中的元素时，倾向使用对象所提供的方法进行访问，而不是直接调用对象属性上的 `[n]` 方法。这种做法可以防止你在 `nil` 对象上调用 `[]`。


  ```Ruby
  # 差
  Regexp.last_match[1]

  # 好
  Regexp.last_match(1)
  ```

* 当为集合提供存取器时，尽量支持索引值为 `nil` 的访问形式。


  ```Ruby
  # 差
  def awesome_things
    @awesome_things
  end

  # 好
  def awesome_things(index = nil)
    if index && @awesome_things
      @awesome_things[index]
    else
      @awesome_things
    end
  end
  ```

## 数值

* 通过 `Integer` 检查对象是否是数值类型，而不是 `Fixnum` 或 `Bignum`。因为 `Fixnum` 或 `Bignum` 表达的数值大小存在范围限定。


  ```Ruby
  timestamp = Time.now.to_i

  # 差
  timestamp.is_a? Fixnum
  timestamp.is_a? Bignum

  # 好
  timestamp.is_a? Integer
  ```

* 对于随机数的生成，倾向使用 Range 来表示，而不是 Integer + 偏移量，这样可以更加清晰地表达你的意图，类比于投掷骰子。


  ```Ruby
  # 差
  rand(6) + 1

  # 好
  rand(1..6)
  ```

## 字符串

* 倾向使用字符串插值或字符串格式化，而不是字符串拼接。


  ```Ruby
  # 差
  email_with_name = user.name + ' <' + user.email + '>'

  # 好
  email_with_name = "#{user.name} <#{user.email}>"

  # 好
  email_with_name = format('%s <%s>', user.name, user.email)
  ```

* 使用统一的风格创建字符串字面量。在 Ruby 社区中存在两种流行的风格：默认单引号（风格 A）与默认双引号（风格 B）。


*   **（风格 A）** 当你不需要字符串插值或特殊字符（比如 `\t`、`\n`、`'`）时，倾向使用单引号。

    ```Ruby
    # 差
    name = "Bozhidar"

    # 好
    name = 'Bozhidar'
    ```

* **（风格 B）** 除非字符串中包含双引号，或是你希望抑制转义字符，否则倾向使用双引号。

    ```Ruby
    # 差
    name = 'Bozhidar'

    # 好
    name = "Bozhidar"
    ```

  本指南使用第一种风格。

* 不要使用 `?x` 字面量语法。在 Ruby 1.9 之后，`?x` 与 `'x'`（只包含单个字符的字符串）是等价的。


  ```Ruby
  # 差
  char = ?c

  # 好
  char = 'c'
  ```

* 不要忘记使用 `{}` 包裹字符串插值中的实例变量或全局变量。


  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    # 差 - 语法正确，但略显笨拙
    def to_s
      "#@first_name #@last_name"
    end

    # 好
    def to_s
      "#{@first_name} #{@last_name}"
    end
  end

  $global = 0

  # 差
  puts "$global = #$global"

  # 好
  puts "$global = #{$global}"
  ```

* 在字符串插值中，不要显式调用 `Object#to_s` 方法，Ruby 会自动调用它。


  ```Ruby
  # 差
  message = "This is the #{result.to_s}."

  # 好
  message = "This is the #{result}."
  ```

* 当你需要构造巨大的数据块时，避免使用 `String#+`，使用 `String#<<` 来替代。`String#<<` 通过修改原始对象进行拼接工作，其比 `String#+` 效率更高，因为后者需要产生一堆新的字符串对象。


  ```Ruby
  # 差
  html = ''
  html += '<h1>Page title</h1>'

  paragraphs.each do |paragraph|
    html += "<p>#{paragraph}</p>"
  end

  # 好 - 并且效率更高
  html = ''
  html << '<h1>Page title</h1>'

  paragraphs.each do |paragraph|
    html << "<p>#{paragraph}</p>"
  end
  ```

* 当存在更快速、更专业的替代方案时，不要使用 `String#gsub`。


    ​```Ruby
    url = 'http://example.com'
    str = 'lisp-case-rules'
    
    # 差
    url.gsub('http://', 'https://')
    str.gsub('-', '_')
    
    # 好
    url.sub('http://', 'https://')
    str.tr('-', '_')
    ​```

* heredocs 中的多行文本会保留各行的前导空白。因此做好如何缩排的规划。


  ```Ruby
  code = <<-END.gsub(/^\s+\|/, '')
    |def test
    |  some_method
    |  other_method
    |end
  END
  # => "def test\n  some_method\n  other_method\nend\n"
  ```

* 使用 Ruby 2.3 新增的 `<<~` 操作符来缩排 heredocs 中的多行文本。


  ```Ruby
  # 差 - 使用 Powerpack 程序库的 String#strip_margin
  code = <<-END.strip_margin('|')
    |def test
    |  some_method
    |  other_method
    |end
  END

  # 差
  code = <<-END
  def test
    some_method
    other_method
  end
  END

  # 好
  code = <<~END
    def test
      some_method
      other_method
    end
  END
  ```

## 日期与时间

* 避免使用 `DateTime`，除非你确实需要处理历法改革（儒略/格里历的改革），此时通过设置 `start` 参数来明确你的意图。


  ```Ruby
  # 差 - 使用 DateTime 表示当前时间
  DateTime.now

  # 好 - 使用 Time 表示当前时间
  Time.now

  # 差 - 使用 DateTime 表示近现代日期
  DateTime.iso8601('2016-06-29')

  # 好 - 使用 Date 表示近现代日期
  Date.iso8601('2016-06-29')

  # 好 - 使用 DateTime 表示日期，通过设置 start 参数为 Date::ENGLANG 明确表示使用 England 历法改革版本
  DateTime.iso8601('1751-04-23', Date::ENGLAND)
  ```

## 正则表达式

> 有些人在面对问题时，不经大脑便认为，“我知道，这里该用正则表达式”。现在他要面对两个问题了。<br>
> ——Jamie Zawinski

* 如果只是在字符串中进行简单的文本搜索，不要使用正则表达式，比如 `string['text']`。


* 对于简单的构建操作，使用正则表达式作为索引即可。


  ```Ruby
  match = string[/regexp/]             # 获取匹配的内容
  first_group = string[/text(grp)/, 1] # 获取匹配的分组（grp）的内容
  string[/text (grp)/, 1] = 'replace'  # string => 'text replace'
  ```

* 当你不需要分组结果时，使用非捕获组。


  ```Ruby
  # 差
  /(first|second)/

  # 好
  /(?:first|second)/
  ```

* 避免使用 Perl 风格的、用以代表最近的捕获组的特殊变量（比如 `$1`、`$2` 等）。使用 `Regexp.last_match(n)` 来替代。


  ```Ruby
  /(regexp)/ =~ string
  ...

  # 差
  process $1

  # 好
  process Regexp.last_match(1)
  ```

* 避免使用数字来获取分组。因为很难明白它们代表的含义。使用命名分组来替代。


  ```Ruby
  # 差
  /(regexp)/ =~ string
  ...
  process Regexp.last_match(1)

  # 好
  /(?<meaningful_var>regexp)/ =~ string
  ...
  process meaningful_var
  ```

* 在字符类别中，只有少数几个你需要特别关心的特殊字符：`^`、`-`、`\`、`]`，所以你不需要转义 `[]` 中的 `.` 与中括号。


* 小心使用 `^` 与 `$` ，它们匹配的是一行的开始与结束，而不是字符串的开始与结束。如果你想要匹配整个字符串，使用 `\A` 与 `\z`。(注意，`\Z` 实为 `/\n?\z/`)


  ```Ruby
  string = "some injection\nusername"
  string[/^username$/]   # 匹配成功
  string[/\Ausername\z/] # 匹配失败
  ```

* 对于复杂的正则表达式，使用 `x` 修饰符。这种做法不但可以提高可读性，而且允许你加入必要的注释。注意的是，空白字符会被忽略。


  ```Ruby
  regexp = /
    start         # some text
    \s            # white space char
    (group)       # first group
    (?:alt1|alt2) # some alternation
    end
  /x
  ```

* 对于复杂的替换，使用 `sub/gsub` 与哈希或区块组合的调用形式。


  ```Ruby
  words = 'foo bar'
  words.sub(/f/, 'f' => 'F') # => 'Foo bar'
  words.gsub(/\w+/) { |word| word.capitalize } # => 'Foo Bar'
  ```

## 百分号字面量

* 只有当字符串中同时存在插值与双引号，且是单行时，才使用 `%()`（`%Q` 的简写形式）。多行字符串，倾向使用 heredocs。


  ```Ruby
  # 差 - 不存在插值
  %(<div class="text">Some text</div>)
  # 应当使用 '<div class="text">Some text</div>'

  # 差 - 不存在双引号
  %(This is #{quality} style)
  # 应当使用 "This is #{quality} style"

  # 差 - 多行字符串
  %(<div>\n<span class="big">#{exclamation}</span>\n</div>)
  # 应当使用 heredocs

  # 好 - 同时存在插值与双引号，且是单行字符串
  %(<tr><td class="name">#{name}</td>)
  ```

* 避免使用 `%()` 或 `%q`，除非字符串同时存在 `'` 与 `"`。优先考虑更具可读性的常规字符串，除非字符串中存在大量需要转义的字符。


  ```Ruby
  # 差
  name = %q(Bruce Wayne)
  time = %q(8 o'clock)
  question = %q("What did you say?")

  # 好
  name = 'Bruce Wayne'
  time = "8 o'clock"
  question = '"What did you say?"'
  quote = %q(<p class='quote'>"What did you say?"</p>)
  ```

* 只有当正则表达式中存在一个或以上的 `/` 字符时，才使用 `%r`。


  ```Ruby
  # 差
  %r{\s+}

  # 好
  %r{^/(.*)$}
  %r{^/blog/2011/(.*)$}
  ```

* 除非调用的命令使用了反引号（这种情况并不多见），否则不要使用 `%x`。


  ```Ruby
  # 差
  date = %x(date)

  # 好
  date = `date`
  echo = %x(echo `date`)
  ```

* 避免使用 `%s`。倾向使用 `:"some string"` 来创建含有空白字符的符号。


* 针对不同的百分号字面量，使用不同的括号类型。

  - 针对构建字符串的 `%q`, `%Q` 字面量，使用 `()`。
  - 针对构建数组的 `%w`, `%i`, `%W`, `%I` 字面量，使用 `[]`，以与常规的数组字面量保持一致。
  - 针对构建正则的 `%r` 字面量，使用 `{}`，此乃惯例。
  - 针对 `%s`, `%x` 等其他字面量，使用 `()`。

  ```Ruby
  # 差
  %q{"Test's king!", John said.}

  # 好
  %q("Test's king!", John said.)

  # 差
  %w(one two three)
  %i(one two three)

  # 好
  %w[one two three]
  %i[one two three]

  # 差
  %r((\w+)-(\d+))
  %r{\w{1,2}\d{2,5}}

  # 好
  %r{(\w+)-(\d+)}
  %r|\w{1,2}\d{2,5}|
  ```

## 元编程

* 避免无谓的元编程。


* 当编写程序库时，不要使核心类混乱（不要使用 monkey patch）。


* 对于 `class_eval` 方法，倾向使用区块形式，而不是字符串插值形式。


-   当使用字符串插值形式时，总是提供 `__FILE__` 及 `__LINE__`，以使你的调用栈看起来具有意义：

    ```Ruby
    class_eval 'def use_relative_model_naming?; true; end', __FILE__, __LINE__
    ```

- 倾向使用 `define_method` 而不是 `class_eval { def ... }`

* 当使用 `class_eval`（或其他的 `eval`）的字符串插值形式时，添加一个注释区块来说明它是如何工作的（来自 Rails 代码中的技巧）。


  ```Ruby
  # 摘录自 activesupport/lib/active_support/core_ext/string/output_safety.rb
  UNSAFE_STRING_METHODS.each do |unsafe_method|
    if 'String'.respond_to?(unsafe_method)
      class_eval <<-EOT, __FILE__, __LINE__ + 1
        def #{unsafe_method}(*params, &block)       # def capitalize(*params, &block)
          to_str.#{unsafe_method}(*params, &block)  #   to_str.capitalize(*params, &block)
        end                                         # end

        def #{unsafe_method}!(*params)              # def capitalize!(*params)
          @dirty = true                             #   @dirty = true
          super                                     #   super
        end                                         # end
      EOT
    end
  end
  ```

* 避免使用 `method_missing`。它会使你的调用栈变得凌乱；其方法不被罗列在 `#methods` 中；拼错的方法可能会默默地工作（`nukes.launch_state = false`）。优先考虑使用委托、代理、或是 `define_method` 来替代。如果你必须使用 `method_missing` 的话，务必做到以下几点：


-   确保[同时定义了 `respond_to_missing?`](http://blog.marc-andre.ca/2010/11/methodmissing-politely.html)。
  - 仅仅捕获那些具有良好语义前缀的方法，像是 `find_by_*`——让你的代码愈确定愈好。
  - 在语句的最后调用 `super`。
  - 委托到确定的、非魔术的方法，比如：

    ```Ruby
    # 差
    def method_missing?(meth, *params, &block)
      if /^find_by_(?<prop>.*)/ =~ meth
        # ... 一堆处理 find_by 的代码
      else
        super
      end
    end

    # 好
    def method_missing?(meth, *params, &block)
      if /^find_by_(?<prop>.*)/ =~ meth
        find_by(prop, *params, &block)
      else
        super
      end
    end

    # 最好的方式可能是在每个需要支持的属性被声明时，使用 define_method 定义对应的方法
    ```

* 倾向使用 `public_send` 而不是 `send`，因为 `send` 会无视 `private/protected` 的可见性。


  ```Ruby
  module Activatable
    extend ActiveSupport::Concern

    included do
      before_create :create_token
    end

    private

    def reset_token
      ...
    end

    def create_token
      ...
    end

    def activate!
      ...
    end
  end

  class Organization < ActiveRecord::Base
    include Activatable
  end

  linux_organization = Organization.find(...)

  # 差 - 会破坏对象的封装性
  linux_organization.send(:reset_token)

  # 好 - 会抛出异常
  linux_organization.public_send(:reset_token)
  ```

* 倾向使用 `__send__` 而不是 `send`，因为 `send` 可能会被覆写。


  ```Ruby
  require 'socket'

  u1 = UDPSocket.new
  u1.bind('127.0.0.1', 4913)
  u2 = UDPSocket.new
  u2.connect('127.0.0.1', 4913)

  # 这里不会调用 u2 的 sleep 方法，而是通过 UDP socket 发送一条消息
  u2.send :sleep, 0

  # 动态调用 u2 的某个方法
  u2.__send__ ...
  ```

## 其他

* 总是开启 `ruby -w` 选项，以编写安全的代码。


* 避免使用哈希作为可选参数。这个方法是不是做太多事了？（对象构造器除外）


* 避免单个方法的长度超过 10 行（不计入空行）。理想上，大部分方法应当不超过 5 行。


* 避免参数列表数目多于三或四个。


* 如果你真的需要“全局”方法，将它们添加到 `Kernel` 并设为私有。


* 使用模块实例变量而不是全局变量。


  ```Ruby
  # 差
  $foo_bar = 1

  # 好
  module Foo
    class << self
      attr_accessor :bar
    end
  end

  Foo.bar = 1
  ```

* 使用 `OptionParser` 来解析复杂的命令行选项。使用 `ruby -s` 来处理琐碎的命令行选项。


* 使用 `Time.now` 而不是 `Time.new` 来获取当前的系统时间。


* 使用函数式思维编写程序，避免副作用。


* 不要修改参数值，除非那就是这个方法的作用。


* 避免使用三层以上的嵌套区块。


* 保持一致性。在理想的世界里，遵循这些准则。


* 使用常识。


## 工具

以下的一些工具可以帮助你自动检查项目中的 Ruby 代码是否符合这份指南。
* RuboCop
* RubyMine

