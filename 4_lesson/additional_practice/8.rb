# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
  p numbers
end


# Weston's answer:
# This should remove each of the items in the array, because each item is shifted out of the array
# i.e. The original array is modified when shift is called.

=begin ---After running the code and doing some detailed testing

1. The 'each' method is looping through each items in the array, but 'shift' is changing each item in the array.
2. The first pass through of the index (index 0) returns a 1
3. The array is then modified and the one is removed from the array.
4. On the second pass through of the array (index 1), the program returns a 3 because the 3 is now the
item at index 1.
5. Then the 2 is removed from the array and the loop ends because there's nothing left at index 2.

=end

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end


=begin --Weston's answer:

1. Loop one, index 0
2. p number 1, because the 1 is in index 0
3. numbers after pop is [1,2,3]
4. Loop two, index 1
5. p number 2, because the 2 is in index 1
6. numbers after pop is [1,2]
7. Loop three, index 2
8. Loop ends because there's nothing in the array in index 2.

=end