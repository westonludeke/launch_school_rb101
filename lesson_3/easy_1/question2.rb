# Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

=begin

1. what is != and where should you use it?
A: Checks if the values do not equal. For example 6 != 5 is true, because 6 does not equal 5.

2. Put ! before something, like !user_name
A: The ! is a not operator, in this case not user_name.

3. put ! after something, like words.uniq!
A: The method will moidfy the object it's called on.

4. put ? before something
A: Used for the ternary operator.

5. put ? after something
A: At the end of a method name, indicates that the method returns a boolean.

6. put !! before something, like !!user_name
A: Not not. Used to convert a value to a boolean.

=end