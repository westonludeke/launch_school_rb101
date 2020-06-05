# A single player Tic Tac Toe game.
require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

@total_score = 0
@beginner = ''

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
# This displays the Tic Tac Toe board
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

# This creates a new, empty board to start the round
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# This makes all of the squares on the board empty
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# This method cleans up the prompt, listing the empty squares available.
def joinor(arr, punc = ", ", or_and = "or")
  new_arr = []
  arr.map!(&:to_s)
  last = arr.pop
  if arr.length > 1
    arr.each { |value| new_arr << value + punc }
  else
    arr.each { |value| new_arr << value + " " }
  end

  new_arr << if arr.empty?
               last
             else
               or_and + " " + last
             end
  new_arr.join("")
end

# ---- WHO STARTS THE ROUND ----
def who_starts_the_round?
  @beginner = if @total_score.even?
                'Player'
              else
                'Computer'
              end
end
who_starts_the_round?
# ---- PLAYER SELECTIONS ----
def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Player, choose a square: #{joinor(empty_squares(brd))}:"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

# ---- COMPUTER SELECTION METHODS ----

# ---- COMPUTER SELECTS #5 ----
# The computer will always select square #5 first if it's available.
def computer_selects_five
  if brd.values_at(5)[0] == ' '
    # prompt "The Computer selects 5"
    # sleep 3
    square = 5
    brd[square] = COMPUTER_MARKER
  end
end

# ---- COMPUTER GOES FOR THE WIN ----
# If the computer is about to win,
# the computer makes a smart selection in order to seal victory.

# If the player started the round, this method seals victory for the CPU
def computer_seals_victory_player_round
  if (brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
     brd.values_at(*line).count(PLAYER_MARKER) == 0) && \
     brd.values.count('X') > brd.values.count('O')
    # prompt "Computer goes for the win"
    # sleep 3
    line.each do |comp_choice|
      if brd.key?(comp_choice) && brd.values_at(comp_choice)[0] == " "
        square = comp_choice
        brd[square] = COMPUTER_MARKER
      end
    end
  end
end

# If the CPU started the round, this method seals victory for the CPU
def computer_seals_victory_computer_round
  if brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
     brd.values_at(*line).count(PLAYER_MARKER) == 0 &&
     brd.values.count('X') == brd.values.count('O')
    # prompt "Computer goes for the win"
    # sleep 3
    line.each do |comp_choice|
      if brd.key?(comp_choice) && brd.values_at(comp_choice)[0] == " "
        square = comp_choice
        brd[square] = COMPUTER_MARKER
      end
    end
  end
end

# ---- COMPUTER BLOCKS PLAYER VICTORY ----
# If the player is about to win, CPU blocks the player from victory
# First if the player began the round
def block_player_player_round
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
     brd.values_at(*line).count(COMPUTER_MARKER) == 0 &&
     brd.values.count('X') > brd.values.count('O')
    # prompt "Computer blocks the player from winning."
    # sleep 3
    line.each do |comp_choice|
      if brd.key?(comp_choice) && brd.values_at(comp_choice)[0] == " "
        square = comp_choice
        brd[square] = COMPUTER_MARKER
      end
    end
  end
end

# This methid is the CPU started the round
def block_player_computer_round
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
     brd.values_at(*line).count(COMPUTER_MARKER) == 0 && \
     brd.values.count('X') == brd.values.count('O')
    # prompt "Computer blocks the player from winning."
    # sleep 3
    line.each do |comp_choice|
      if brd.key?(comp_choice) && brd.values_at(comp_choice)[0] == " "
        square = comp_choice
        brd[square] = COMPUTER_MARKER
      end
    end
  end
end

# ---- CPU RANDOM SELECTION ----
# CPU makes a random selection if no other option available.
def computer_random_selection
  # The computer makes a random selection, only if it's the computer's turn.
  # i.e. Only if the computer hasn't made a smart selection above.
  if @beginner == 'Player' && brd.values.count('X') > brd.values.count('O')
    # prompt "The Computer is making a random selection"
    # sleep 3
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  elsif @beginner == 'Computer' && brd.values.count('X') == \
    brd.values.count('O')
    # prompt "The Computer is making a random selection"
    # sleep 3
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

# ---- CALLING THE CPU SELECTION METHODS ----
def computer_places_piece!(brd)
  computer_selects_five
  WINNING_LINES.each do |_line|
    if @beginner == 'Player'
      computer_seals_victory_player_round
    elsif @beginner == 'Computer'
      computer_seals_victory_computer_round
    end
  end
  WINNING_LINES.each do |_line|
    if @beginner == 'Player'
      block_player_player_round
    elsif @beginner == 'Computer'
      block_player_computer_round
    end
  end
  computer_random_selection
  display_board(brd)
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

# ---- SCORING ----
def final_score
  if player_score == 5
    prompt "The player has won the game with #{player_score} wins" \
    "against the computer's #{computer_score} wins and #{tie_games} ties." \
    "Good job!"
  elsif computer_score == 5
    prompt "The computer has won the game with #{computer_score} victories" \
    "against your #{player_score} wins and #{tie_games} ties." \
    "Better luck next time."
  end
end

def beginning_round_prompt
  prompt "#{@total_score} rounds have been played so far."
  prompt "The #{@beginner} will start off this round!"
  sleep 3
end

def end_round_prompt
  # ---- SEE IF SOMEONE ONE THE ROUND
  if someone_won?(board)
    prompt "The #{detect_winner(board)} won this round!"
    @scoreboard << detect_winner(board)
  else
    @tie_games += 1
    prompt "It's a tie!"
  end

  @player_score = @scoreboard.count("Player")
  @computer_score = @scoreboard.count("Computer")
  @total_score = (@player_score + @computer_score + @tie_games)

  if @player_score < 5 && @computer_score < 5
    prompt "The Player currently has #{@player_score} wins." \
    "The computer has #{@computer_score} wins." \
    "There have been #{@tie_games} ties."
    prompt "The next round will begin soon!"
    who_starts_the_round?
  else
    prompt "We have game winner! Calculating final scores now..."
  end
  # Delay to show the current score before resetting the board
  sleep 5
end

def game_scoreboard
  @scoreboard = []
  @player_score = 0
  @computer_score = 0
  @tie_games = 0
end

# def selections_loop

# end

def keeping_score
  # Keep going until either player or CPU reaches 5 wins
  until @player_score == 5 || @computer_score == 5
    beginning_round_prompt
    # show empty board at the beginning of the round
    board = initialize_board
    # Loop of selections
    if @beginner == 'Player'
      loop do
        display_board(board)

        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      end
    elsif @beginner == 'Computer'
      loop do
        display_board(board)

        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        display_board(board)
      end
    end
    display_board(board)

    end_round_prompt
  end
  # Final Score Method
  final_score
end
keeping_score

# ----  REPEAT OR END GAME ----
prompt "Would you like to play again? (y or n)"
answer = gets.chomp
if answer.downcase.start_with?('y')
  keeping_score
end
prompt "Thanks for playing Tic Tac Toe! Goodbye!"

=begin ---- GAME NOTES ----
1. Instead of manually choosing who goes first /
   each round alternates between the player choosing first and the computer.
2. The code still needs to be refactored, but the gameplay works.
3. The computer always makes the most optimal choice for the computer.
=end
