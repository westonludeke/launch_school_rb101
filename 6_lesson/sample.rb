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
  if brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
     brd.values_at(*line).count(PLAYER_MARKER) == 0 &&
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
  if @beginner == 'Player'
    if brd.values.count('X') > brd.values.count('O')
      # prompt "The Computer is making a random selection"
      # sleep 3
      square = empty_squares(brd).sample
      brd[square] = COMPUTER_MARKER
    end
  elsif @beginner == 'Computer'
    if brd.values.count('X') == brd.values.count('O')
      # prompt "The Computer is making a random selection"
      # sleep 3
      square = empty_squares(brd).sample
      brd[square] = COMPUTER_MARKER
    end
  end
end

# ---- CALLING THE CPU SELECTION METHODS ----
def computer_places_piece!(brd)
  computer_selects_five
  WINNING_LINES.each do |line|
    if @beginner == 'Player'
      computer_seals_victory_player_round
    elsif @beginner == 'Computer'
      computer_seals_victory_computer_round
    end
  end
  WINNING_LINES.each do |line|
    if @beginner == 'Player'
      block_player_player_round
    elsif @beginner == 'Computer'
      block_player_computer_round
    end
  end
  computer_random_selection
  display_board(brd)
end

