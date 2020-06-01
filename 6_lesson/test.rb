require 'pry'

line = [1,2,3]

brd = {1 => 'X', 2 => 'X', 3 => ' ', 4 => 'O'}

#p brd.values.count('X') > brd.values.count('O')


if brd.values_at(3)[0] == ' '
  puts "yes"
end


# if (brd.values_at(*line).count(COMPUTER_MARKER) == 2 && brd.values.count('X') > brd.values.count('O')) || 
#    (brd.values_at(*line).count(PLAYER_MARKER) == 2 && brd.values.count('X') > brd.values.count('O'))
   
#   line.each do |comp_choice|
#     if brd.key?(comp_choice)
#       if brd.values_at(comp_choice)[0] == " "
#         square = comp_choice
#         brd[square] = COMPUTER_MARKER
#       end
#     end
#   end
# end
