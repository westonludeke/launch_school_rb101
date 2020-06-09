=begin  ---- A single player Tic Tac Toe game ----

 ---- GAME NOTES ----
1. Instead of manually choosing who goes first /
   each round alternates between the player choosing first and the computer.

2. The computer always makes the most optimal choice for the computer.
  2a. This means always selecting space #5 if available.

3. I used instance variables for scoring because I didn't know how to /
properly refactor without them.

4. The code isn't nearly as DRY as it should be, but passes all of the /
Rubocop tests.

=end

=begin ---- TO-DO LIST ----

3. One small issue you could address with your code is that the program indicates an answer of y or n is accepted when asking whether the user is ready to play. In reality, the program will accept any input beginning with y or n, meaning that 'yellow' will be accepted as 'yes' and 'now' is accepted as no…

4. Finally, it would be good to clear the screen after each round.


=end

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

def welcome
  prompt "Welcome to Tic Tac Toe!"
  prompt "First to win five rounds wins the game."
  sleep 3
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

def who_starts
  @beginner = if @total_score.even?
                'Player'
              else
                'Computer'
              end
end
who_starts

# ---- PLAYER SELECTIONS ----
def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Player, choose a square: #{joinor(empty_squares(brd))}:"
    square = gets.chomp.to_f
    break if empty_squares(brd).include?(square) && square % 1 == 0
    prompt "Sorry, that's not a valid choice."
  end
  brd[square.to_i] = PLAYER_MARKER
end

# ---- COMPUTER SELECTIONS ----
def computer_selects_five(brd)
  if brd.values_at(5)[0] == ' '
    square = 5
    brd[square] = COMPUTER_MARKER
  end
end

def computer_choice(brd, line)
  line.each do |comp_choice|
    if brd.key?(comp_choice) && brd.values_at(comp_choice)[0] == " "
      square = comp_choice
      brd[square] = COMPUTER_MARKER
    end
  end
end

def computer_random_choice(brd)
  if @beginner == 'Player'
    if brd.values.count('X') > brd.values.count('O')
      square = empty_squares(brd).sample
      brd[square] = COMPUTER_MARKER
    end
  elsif @beginner == 'Computer'
    if brd.values.count('X') == brd.values.count('O')
      square = empty_squares(brd).sample
      brd[square] = COMPUTER_MARKER
    end
  end
end

def computer_win_player_started_round(brd, line)
  if brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
     brd.values_at(*line).count(PLAYER_MARKER) == 0 &&
     brd.values.count('X') > brd.values.count('O')

    computer_choice(brd, line)
  end
end

def computer_win_computer_started_round(brd, line)
  if brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
     brd.values_at(*line).count(PLAYER_MARKER) == 0 &&
     brd.values.count('X') == brd.values.count('O')
    computer_choice(brd, line)
  end
end

def computer_seals_victory(brd)
  WINNING_LINES.each do |line|
    if @beginner == 'Player'
      computer_win_player_started_round(brd, line)
    elsif @beginner == 'Computer'
      computer_win_computer_started_round(brd, line)
    end
  end
end

def cpu_block_player_started_round(brd, line)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
     brd.values_at(*line).count(COMPUTER_MARKER) == 0 &&
     brd.values.count('X') > brd.values.count('O')
    computer_choice(brd, line)
  end
end

def cpu_block_cpu_started_round(brd, line)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
     brd.values_at(*line).count(COMPUTER_MARKER) == 0 && \
     brd.values.count('X') == brd.values.count('O')
    computer_choice(brd, line)
  end
end

def computer_blocks_player(brd)
  WINNING_LINES.each do |line|
    if @beginner == 'Player'
      cpu_block_player_started_round(brd, line)
    elsif @beginner == 'Computer'
      cpu_block_cpu_started_round(brd, line)
    end
  end
end

def computer_places_piece!(brd)
  computer_selects_five(brd)
  computer_seals_victory(brd)
  computer_blocks_player(brd)
  computer_random_choice(brd)
  display_board(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

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

# ---- SCORING AND GAMEPLAY ----
def keep_score
  @scoreboard = []
  @player_score = 0
  @computer_score = 0
  @tie_games = 0
end

def beginning_round_prompt
  if @total_score == 0
    welcome
  end
  prompt "#{@total_score} rounds have been played so far."
  prompt "The #{@beginner} will start off this round!"
  sleep 3
end

def begin_player_loop(board)
  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end
end

def begin_computer_loop(board)
  loop do
    display_board(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
    display_board(board)
  end
end

def selection_loop(board)
  if @beginner == 'Player'
    begin_player_loop(board)
  elsif @beginner == 'Computer'
    begin_computer_loop(board)
  end
  display_board(board)
end

def winner_round_prompt(board)
  prompt "The #{detect_winner(board)} won this round!"
  @scoreboard << detect_winner(board)
end

def tie_round_prompt
  @tie_games += 1
  prompt "It's a tie!"
end

def score_check
  if @player_score < 5 && @computer_score < 5
    end_round_prompt
  else
    prompt "We have game winner! Calculating final scores now..."
  end
  sleep 5
end

def end_round_prompt
  prompt "The Player currently has #{@player_score} wins. " \
  "The computer has #{@computer_score} wins. " \
  "There have been #{@tie_games} ties. "
  prompt "The next round will begin soon!"
  who_starts
end

def end_round_score_update
  @player_score = @scoreboard.count("Player")
  @computer_score = @scoreboard.count("Computer")
  @total_score = (@player_score + @computer_score + @tie_games)
end

def winner_check
  if @player_score == 5
    player_won_game
  elsif @computer_score == 5
    computer_won_game
  end
end

def player_won_game
  prompt "The player has won the game with #{@player_score} wins" \
  "against the computer's #{@computer_score} wins and #{@tie_games} ties." \
  "Good job!"
end

def computer_won_game
  prompt "The computer has won the game with #{@computer_score} victories " \
  "against your #{@player_score} wins and #{@tie_games} ties. " \
  "Better luck next time."
end

def play
  keep_score
  until @player_score == 5 || @computer_score == 5
    beginning_round_prompt
    # show empty board at the beginning of the round
    board = initialize_board
    selection_loop(board)

    if someone_won?(board)
      winner_round_prompt(board)
    else
      tie_round_prompt
    end
    end_round_score_update
    score_check
  end
  winner_check
end

play

def play_again
  @total_score = 0
  prompt "Would you like to play again? (y or n)"
  answer = gets.chomp
  if answer.downcase.start_with?('y')
    play
  end
  prompt "Thanks for playing Tic Tac Toe! Goodbye!"
end 
play_again
