def get_current_player_card_value(keep_score)
  keep_score['player_card_values'].clear

  keep_score['player_cards'].each do |card|
    keep_score['player_card_values'] << card[1]
  end
end
get_current_player_card_value(keep_score)

def get_current_dealer_card_value(keep_score)
  keep_score['dealer_card_values'].clear

  keep_score['dealer_cards'].each do |card|
    keep_score['dealer_card_values'] << card[1]
  end
end
get_current_dealer_card_value(keep_score)

# ----

def get_current_card_value(keep_score)
  keep_score['player_card_values'].clear
  keep_score['dealer_card_values'].clear

  
  keep_score['player_cards'].each do |card|
    keep_score['player_card_values'] << card[1]
  end

  keep_score['dealer_cards'].each do |card|
    keep_score['dealer_card_values'] << card[1]
  end
end
get_current_card_value(keep_score)