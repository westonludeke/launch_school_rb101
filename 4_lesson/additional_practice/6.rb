# Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Weston's Answer:
p flintstones.map! { |x| x[0..2] }
p flintstones