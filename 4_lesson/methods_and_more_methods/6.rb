# What is the return value of the following statement? Why?

p ['ant', 'bear', 'caterpillar'].pop.size


# Pop removes the last element from the array
# Size is the same as length, which returns the length of the array

# Weston's answer: The return value is 1 because pop removes the last item in the array ("caterpillar") and returns it
# and size is the length of the array after running pop, which is now one

# I was wrong, size is not being called on the array size, but on the size of the value in the array, the value being "caterpillar"