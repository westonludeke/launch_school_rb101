keep_score = { 'player_current_card_value' => 'ace', \
               'dealer_current_card_value' => 'king', \
               'player_current_card_points' => 0, \
               'dealer_current_card_points' => 0, \
               'player_game_score' => 0, \
               'dealer_game_score' => 0}


def convert_face_cards_to_ten(keep_score)
  if keep_score['player_current_card_value'].is_a? Integer
    keep_score['player_hand_points'] = keep_score['player_current_card_value']
  elsif 
    keep_score['dealer_current_card_value'].is_a? Integer
    keep_score['dealer_hand_points'] = keep_score['dealer_hand_points']
  end
convert_face_cards_to_ten(keep_score)

p keep_score

