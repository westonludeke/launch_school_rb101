# A single player Tic Tac Toe game.
require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
# This displays the Tic Tac Toe board with the selections filled out as the game progresses
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

# This creates a new, empty board to start the game
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# This makes all of the squares empty
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# This method cleans up the prompt
def joinor(arr, punc = ", ", or_and = "or")
  new_arr = []
  # Convert all integers in the array to a string
  arr.map! do |val|
    val.to_s
  end
  # Removes the last array item
  last = arr.pop
  
  if arr.length > 1
    arr.each do |value|
      new_arr << value + punc
    end
  else 
    arr.each do |value|
      new_arr << value + " "
    end
  end 

  if arr.length == 0
    new_arr << last
  else 
    new_arr << or_and + " " + last
  end
  new_arr.join("")
end

# This gets the player's selection and marks it on the board.
def player_places_piece!(brd)
  square = ''
  loop do
    #prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    prompt "Choose a square: #{joinor(empty_squares(brd))}:"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

# This gets the computer's selection and marks it on the board.
def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

# Sees if the entire board has been filled out
def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

# This is to find out who won the game, if there's a winner.
def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Would you like to play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"

# rubocop:disable Metrics/LineLength
=begin ----GAME DESCRIPTION----

Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
marks a square on the board. First player to reach 3 squares in a row, including diagonals,
wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.


----PSEUDOCODE----

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. (Loop 1) - If neither winner nor board is full, go to #2
8. Play again?
9. (Loop 2) - If yes, go to #1
10. Good bye!

You can see from the above sequence that there are two main loops -- one at step #7, after either the winner is found or the board is full, and another at step #9, after we ask if the user wants to play again. You can also notice that we are using higher level pseudo-code, and it's not formal pseudo-code. The reason is because we are staying at a zoomed out higher level for now, and all the imperative code -- the step by step directions -- is encapsulated into sub-processes. For example, the "display the board" doesn't go into exactly how we should display the board. We'll just trust that a sub-process, or function, can take care of it. In other words, we trust we can figure that part out, but we need to focus on higher level thinking right now.

----FLOWCHART----

https://d1b1wr57ag5rdp.cloudfront.net/images/ttt_flowchart.png

Notice there's a lot of rectangle boxes, which stands for some sort of processing. The general flow is here, but it's a much higher level flowchart than what we've been working with in the past. You can see that the sub-processes will need to work with some sort of "board". Every sub-process, from "Display board", to "User marks square", to "board full?", requires inspecting the board. In some cases, like when we need to mark a square, we'll even have to permanently modify the board state.

With this flow chart in hand, we're finally ready to take our first step in writing some code.

Note: yes, you could spend more time here by writing out formal pseudo-code for each sub-process. That would be a far more detailed approach, and would be a great technique for a program that's more complicated. If you're still having a hard time deconstructing the logic of this program, go ahead and take that step. Zoom-in to each sub-process and try to outline exactly how to approach that problem.

=end
