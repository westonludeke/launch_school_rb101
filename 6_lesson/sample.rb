keep_score = { 'player_cards' => [], \
               'dealer_cards' => [], \
               'player_card_values' => ["ace", "king"], \
               'dealer_card_values' => ["ace", "ace", "ace", "queen"], \
               'player_points' => 0, \
               'dealer_points' => 0, \
               'player_move' => '', \
               'dealer_move' => '', \
               'end_game' => false }


def convert_aces(keep_score)
  players = keep_score['player_card_values'].select { |card| card == "ace" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "ace" }

  keep_score['player_points'] += players.length * 11
  keep_score['dealer_points'] += dealers.length * 11

end
convert_aces(keep_score)

def reduce_ace_to_one(keep_score)
  players = keep_score['player_card_values'].select { |card| card == "ace" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "ace" }

  players.length.times do
    keep_score['player_points'] -= 10 if keep_score['player_points'] > 21
  end

  dealers.length.times do
    keep_score['dealer_points'] -= 10 if keep_score['dealer_points'] > 21
  end
  
end
reduce_ace_to_one(keep_score)

p keep_score

# def convert_aces(keep_score)
#   players = keep_score['player_card_values'].select { |card| card == "ace" }
#   dealers = keep_score['dealer_card_values'].select { |card| card == "ace" }

#   keep_score['player_points'] += players.length * 11
#   keep_score['dealer_points'] += dealers.length * 11

#   if keep_score['player_points'] > 21
    
#     keep_score['player_points'] -= 10    

# end
# convert_aces(keep_score)
