def prompt(msg)
  puts "=> #{msg}"
end


prompt "select y or n: "
answer = gets.chomp
p answer
if answer.downcase == 'y' || answer.downcase == 'yes'
  p "yes!"
else
  p "no!"
end

