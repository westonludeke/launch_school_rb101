# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# Weston's answer
p ages.min_by { |k, v| v }
# The actual, cleaner answer that returns just the age without Eddie's name:
p ages.values.min