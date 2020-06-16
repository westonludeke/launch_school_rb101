card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'club', 'spade']

keep_score = { 'player_current_card_value' => 'ace', \
               'dealer_current_card_value' => 'ace', \
               'player_hand_points' => 1, \
               'dealer_hand_points' => 10, \
               'player_game_score' => 0, \
               'dealer_game_score' => 0}




def score_check(keep_score)
  if keep_score["player_hand_points"] > keep_score["dealer_hand_points"]
    p "player wins!"
    return true
  else
    p "no winner"
    return false
  end
end

def example(keep_score)
  if score_check(keep_score) == true
   score_check(keep_score)
  end
end

example(keep_score)