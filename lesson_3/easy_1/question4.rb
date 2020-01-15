# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:

# What do the following method calls do (assume we reset numbers to the original array between method calls)?

# My guess: This will delete the number 2 because we're deleting the item at index one.
# Correct!
numbers = [1, 2, 3, 4, 5]
p numbers
numbers.delete_at(1)
p numbers



numbers = [1, 2, 3, 4, 5]
p numbers
numbers.delete(1)
p numbers

# My guess is the above will delete the number 1
# Correct!