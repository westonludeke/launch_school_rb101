# Write your own version of the rails titleize implementation.

words = "the flintstones rock"

p words.split.map(&:capitalize).join(' ')