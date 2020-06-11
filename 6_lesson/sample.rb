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

def computer_random_selection(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def computer_random_choice(brd, keep_score)
  if keep_score["beginner"] == 'Player' && \
     brd.values.count('X') > brd.values.count('O')
    computer_random_selection(brd)
  elsif keep_score["beginner"] == 'Computer' && \
        brd.values.count('X') == brd.values.count('O')
    computer_random_selection(brd)
  end
end

# ----- COMPUTER GOES FOR THE WIN ----
def computer_two_spaces_filled(brd, line)
  brd.values_at(*line).count(COMPUTER_MARKER) == 2 && \
    brd.values_at(*line).count(PLAYER_MARKER) == 0
end

def computer_win(brd, line)
  if computer_two_spaces_filled(brd, line) && \
     (brd.values.count('X') > brd.values.count('O'))
    computer_choice(brd, line)
  elsif computer_two_spaces_filled(brd, line) && \
        (brd.values.count('X') == brd.values.count('O'))
    computer_choice(brd, line)
  end
end

def computer_seals_victory(brd, keep_score)
  WINNING_LINES.each do |line|
    if keep_score["beginner"] == 'Player'
      computer_win(brd, line)
    elsif keep_score["beginner"] == 'Computer'
      computer_win(brd, line)
    end
  end
end

# ---- COMPUTER BLOCKS PLAYER VICTORY
def player_one_square_away(brd, line)
  brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
    brd.values_at(*line).count(COMPUTER_MARKER) == 0
end

def rounds_played_even(brd, line)
  if brd.values.count('X') > brd.values.count('O')
    computer_choice(brd, line)
  end
end

def rounds_played_odd(brd, line)
  if brd.values.count('X') == brd.values.count('O')
    computer_choice(brd, line)
  end
end

def computer_blocks_player(brd, keep_score)
  WINNING_LINES.each do |line|
    if player_one_square_away(brd, line)
      if keep_score["rounds_played"].even?
        rounds_played_even(brd, line)
      elsif keep_score["rounds_played"].odd?
        rounds_played_odd(brd, line)
      end
    end
  end
end

