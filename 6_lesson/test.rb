card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'club', 'spade']

keep_score = { 'player_current_card_value' => 'ace', \
               'dealer_current_card_value' => 'ace', \
               'player_hand_points' => 1, \
               'dealer_hand_points' => 10, \
               'player_game_score' => 0, \
               'dealer_game_score' => 0}




def get_current_card_value(player_hand, dealer_hand, keep_score)
  player_hand["jack", 10]
  dealer_hand[]
  # -- Add these to an array inside the hash
  player_hand.shift
  dealer_hand.shift
end
get_current_card_value(player_hand, dealer_hand, keep_score)