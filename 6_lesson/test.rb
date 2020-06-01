WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
COMPUTER_MARKER = 'O'
PLAYER_MARKER = 'X'

brd = {1 => 'X', 2 => 'X', 3 => ' ', 4 => 'O'}

#p brd.values.count('X') > brd.values.count('O')

p brd.values_at(*line).count('X') == 2 && brd.values_at(*line).count('O') == 0
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
