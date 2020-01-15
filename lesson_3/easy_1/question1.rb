# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# My expectation: 1,2,3
# Reality: 1,2,2,3
# I was wrong because the program is calling puts on 'numbers' and not 'numbers.uniq'