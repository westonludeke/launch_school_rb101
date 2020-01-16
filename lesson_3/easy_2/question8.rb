# Shorten this sentence:
advice = "Few things in life are as important as house training your pet dinosaur."

=begin
...remove everything starting from "house".

Review the String#slice! documentation, and use that method to make the return value 
"Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur.".

As a bonus, what happens if you use the String#slice method instead?
=end

p advice.slice(/F.*as/)
p advice

  
# Answer: With the ! it modifies the original sentence, without the ! it modifies the original
# but calling the variable still returns the full stentence.
  


