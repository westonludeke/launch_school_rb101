# Given this nested Hash,figure out the total age of just the male members of the family.


munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# My Answer:
munsters.select! { |k, v| v["gender"]== "male" }

total = munsters.inject(0) { |i, j| i + j.last["age"].to_i}
p total

# Launch School Answer:
# total_male_age = 0
# munsters.each_value do |details|
#   total_male_age += details["age"] if details["gender"] == "male"
# end

# total_male_age # => 444

