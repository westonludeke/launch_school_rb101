# Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an additional "age_group" 
# key that has one of three values describing the age group the family member is in (kid, adult, or senior).

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.
# Hint: Try using a case statement along with Ruby Range objects in your solution

=begin ----PSEUDOCODE----

1. Loop through the Munsters Hash
2. For each item in the Munsters Hash,
3. Select the Nested Hash,
4. Look up the value of the Age key
5. If the Age is 0-17, change the Age_Group to Kid
6. If the Age is 18-64, change the Age_Group to Adult
7. Else Age_Group is Senior

---- NEXT STEPS ------

Find out how to look up the age value for each member of the Munster family and return the output to the console.

=end


munsters.transform_values do |value|
  if value["age"] >= 65
    value["age_group"] = "senior"
  elsif value["age"] > 17 && value["age"] < 65
    value["age_group"] = "adult"
  else
    value["age_group"] = "kid"
  end
end

p munsters

# case munsters
# when -> (h) { h["age"] == 32}
#   puts 'something'
# else
#   puts 'something else'
# end


# This code is to access the Nested Hash and add a new Key and Value
# munsters.each do |key, value|
#   value.merge!({ "age_group" => "adult" }) 
# end

# p munsters