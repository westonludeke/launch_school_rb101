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

require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
GAME_ROUNDS = 5

@beginner = ''
score_hash = {"player_score" => 0, "computer_score" => 0, "tie_games" => 0, "rounds_played" => 0}

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  prompt "Welcome to Tic Tac Toe!"
  prompt "First to win #{GAME_ROUNDS} rounds wins the game."
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

def who_starts(score_hash)
  @beginner = if score_hash["rounds_played"].even?
                'Player'
              else
                'Computer'
              end
end
who_starts(score_hash)

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
  #@player_score = 0
  #@computer_score = 0
  #@tie_games = 0
end

def update_score(score_hash, user, score)
  if user == 'player'
    score_hash['player_score'] += 1
  elsif user == 'computer'
    score_hash['computer_score'] += 1
  end
end

def beginning_round_prompt(score_hash)
  if score_hash["rounds_played"] == 0
    welcome
  end
  prompt "#{score_hash["rounds_played"]} rounds have been played so far."
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

def tie_round_prompt(score_hash)
  score_hash["tie_games"] += 1
  prompt "It's a tie!"
end

def score_check(score_hash)
  if score_hash["player_score"] < GAME_ROUNDS && score_hash["computer_score"] < GAME_ROUNDS
    end_round_prompt(score_hash)
  else
    prompt "We have game winner! Calculating final scores now..."
  end
  sleep 5
end

def end_round_prompt(score_hash)
  prompt "The Player currently has #{score_hash["player_score"]} wins. " \
  "The computer has #{score_hash["computer_score"]} wins. " \
  "There have been #{score_hash["tie_games"]} ties. "
  prompt "The next round will begin soon!"
  who_starts(score_hash)
end

def end_round_score_update(score_hash)
  score_hash["player_score"] = @scoreboard.count("Player")
  score_hash["computer_score"] = @scoreboard.count("Computer")
  score_hash["rounds_played"] = (score_hash["player_score"] + score_hash["computer_score"] + score_hash["tie_games"])
end

def winner_check(score_hash)
  if score_hash["player_score"] == GAME_ROUNDS
    player_won_game(score_hash)
  elsif score_hash["computer_score"] == GAME_ROUNDS
    computer_won_game(score_hash)
  end
end

def player_won_game(score_hash)
  prompt "The player has won the game with #{score_hash["player_score"]} wins" \
  "against the computer's #{score_hash["computer_score"]} wins and #{score_hash["tie_games"]} ties." \
  "Good job!"
end

def computer_won_game(score_hash)
  prompt "The computer has won the game with #{score_hash["computer_score"]} victories " \
  "against your #{score_hash["player_score"]} wins and #{score_hash["tie_games"]} ties. " \
  "Better luck next time."
end

def play(score_hash)
  keep_score
  until score_hash["player_score"] == GAME_ROUNDS || score_hash["computer_score"] == GAME_ROUNDS
    beginning_round_prompt(score_hash)
    # show empty board at the beginning of the round
    board = initialize_board
    selection_loop(board)

    if someone_won?(board)
      winner_round_prompt(board)
    else
      tie_round_prompt(score_hash)
    end
    end_round_score_update(score_hash)
    score_check(score_hash)
  end
  winner_check(score_hash)
end

play(score_hash)

def play_again(score_hash)
  score_hash["rounds_played"] = 0
  prompt "Would you like to play again? (y or n)"
  answer = gets.chomp
  if answer.downcase == ('y') || answer.downcase == ('yes')
    score_hash["player_score"] = 0
    score_hash["computer_score"] = 0
    play(score_hash)
  end
  prompt "Thanks for playing Tic Tac Toe! Goodbye!"
end 
play_again(score_hash)
