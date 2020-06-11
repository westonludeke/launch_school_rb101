def player_one_square_away(brd, line)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 && \
     brd.values_at(*line).count(COMPUTER_MARKER) == 0
  end
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
    player_one_square_away(brd, line)
    if keep_score["rounds_played"].even?
      rounds_played_even(brd, line)
    elsif keep_score["rounds_played"].odd?
      rounds_played_odd(brd, line)
    end
  end
end


def computer_places_piece!(brd, keep_score)
  computer_selects_five(brd)
  computer_seals_victory(brd, keep_score)
  computer_blocks_player(brd, keep_score)
  computer_random_choice(brd, keep_score)
  display_board(brd)
end




