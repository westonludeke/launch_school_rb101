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
#------------------------
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
# ----------
