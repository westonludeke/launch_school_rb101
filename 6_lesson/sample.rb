def convert_face_cards(keep_score)
  keep_score['player_points'] = 0
  keep_score['dealer_points'] = 0

  players = keep_score['player_card_values'].select { |card| card == "jack" || card == "queen" || card == "king" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "jack" || card == "queen" || card == "king" }

  keep_score['player_points'] = players.length * 10
  keep_score['dealer_points'] = dealers.length * 10
end


def add_integer_points(keep_score)
  keep_score['player_card_values'].each do |card|
    if card.is_a? Integer
      keep_score['player_points'] += card
    end
  end
  keep_score['dealer_card_values'].each do |card|
    if card.is_a? Integer
      keep_score['dealer_points'] += card
    end
  end
end


def convert_player_face_cards(keep_score)
  keep_score['player_points'] = 0
  keep_score['player_card_values'].each do |card|
    if card.is_a? Integer
      keep_score['player_points'] += card
    elsif card == "jack" || card == "queen" || card == "king"
      keep_score['player_points'] += 10
    end
  end
end
convert_player_face_cards(keep_score)

def convert_dealer_face_cards(keep_score)
  keep_score['dealer_points'] = 0
  keep_score['dealer_card_values'].each do |card|
    if card.is_a? Integer
      keep_score['dealer_points'] += card
    elsif card == "jack" || card == "queen" || card == "king"
      keep_score['dealer_points'] += 10
    end
  end
end
convert_dealer_face_cards(keep_score)

