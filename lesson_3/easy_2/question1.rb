# In this hash of people and their age,

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# see if "Spot" is present.

p ages.select {|key, hash| key["Spot"]}

# Bonus: What are two other hash methods that would work just as well for this solution?

p ages.find {|key, values| key.include?("Spot")}

p ages.has_key?("Spot")