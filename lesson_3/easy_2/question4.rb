# See if the name "Dino" appears in the string below:

advice = "Few things in life are as important as house training your pet dinosaur."

# my version
p advice.include?("Dino")
# LS answer
p advice.match?("Dino")