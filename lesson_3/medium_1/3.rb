# Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  if number <=0
    puts "Choose a number greater than zero!"
  else
    divisor = number
    factors = []
    begin
      factors << number / divisor if number % divisor == 0
      divisor -= 1
    end until divisor == 0
     p factors
  end
end

factors(8)
factors(0)
factors(-16)

# Alyssa noticed that this will fail if the input is 0, or a negative number,
# and asked Alan to change the loop. How can you make this work without using begin/end/until?
# Note that we're not looking to find the factors for 0 or negative numbers, 
# but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

# Bonus 1: What is the purpose of the number % divisor == 0 ?
# Answer: To make sure the program only returns numbers evenly divided with no remainder.
# i.e. The modulus is used to make sure we only see numbers with a modulus of 0.

# Bonus 2: What is the purpose of the second-to-last line (line 8) in the method
# (the factors before the method's end)?
# Answer: This is to call the method
