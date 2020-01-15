# Starting with the string:

famous_words = "seven years ago..."

# show two different ways to put the expected "Four score and " in front of it.

# A1:

famous_words.insert(0, "Four score and ")
p famous_words
# A2:

famous_words[0,0] = "Four score and "
p famous_words