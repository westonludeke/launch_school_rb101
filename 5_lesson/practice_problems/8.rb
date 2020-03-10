# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

arr = []

hsh.each do |key, value|  
  arr << value
end

combined = arr.flatten
str = combined.join(" ")
no_vowels = str.delete('bcdfghjklmnpqrstvwxyz')
p no_vowels

