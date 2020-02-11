# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

# Example: { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# Weston's Answer:
# Step 1: Remove spaces in the string
remove_spaces = statement.split.join("")
# Split each character in the string into an array
array = remove_spaces.split('')
# Count character frequency and add to hash
p array.inject(Hash.new(0)) { |hash, word| hash[word] +=1; hash}