card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'club', 'spade']

keep_score = { 'player_current_card_value' => 'ace', \
               'dealer_current_card_value' => 'ace', \
               'player_hand_points' => 1, \
               'dealer_hand_points' => 1, \
               'player_game_score' => 0, \
               'dealer_game_score' => 0}

def convert_ace_to_one_or_eleven(keep_score)
  if keep_score['player_current_card_value'] == 'ace'
    if keep_score['player_hand_points'] + 11 <= 21
      keep_score['player_hand_points'] += 11
    else 
      keep_score['player_hand_points'] += 1
    end
  end

  if keep_score['dealer_current_card_value'] == 'ace'
    if keep_score['dealer_hand_points'] + 11 <= 21
      keep_score['dealer_hand_points'] += 11
    else 
      keep_score['dealer_hand_points'] += 1
    end
  end  
end
convert_ace_to_one_or_eleven(keep_score)
p keep_score
convert_ace_to_one_or_eleven(keep_score)
p keep_score