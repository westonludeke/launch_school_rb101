# How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

arr_sorted = arr.map(&:to_i).sort {|x,y| -(x <=> y)}
p arr_sorted