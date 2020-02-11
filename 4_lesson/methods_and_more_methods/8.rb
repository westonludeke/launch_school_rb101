# How does take work? Is it destructive? How can we find out?

arr = [1, 2, 3, 4, 5]
p arr.take(2)
p arr

# Take returns the first n elements in the array.
# No, it's not destructive because calling p on the array after still returns the original array.