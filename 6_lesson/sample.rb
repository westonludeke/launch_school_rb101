def convert_face_cards(keep_score)
  keep_score['player_points'] = 0
  keep_score['dealer_points'] = 0

  players = keep_score['player_card_values'].select { |card| card == "jack" || card == "queen" || card == "king" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "jack" || card == "queen" || card == "king" }

  keep_score['player_points'] = players.length * 10
  keep_score['dealer_points'] = dealers.length * 10
end

def add_integer_points(keep_score)
  players = keep_score['player_card_values'].select { |card| card.is_a? Integer }
  dealers = keep_score['dealer_card_values'].select { |card| card.is_a? Integer }
    
  players.each { |num| keep_score['player_points'] += num}
  dealers.each { |num| keep_score['dealer_points'] += num}
end



def convert_aces(keep_score)
  players = keep_score['player_card_values'].select { |card| card == "ace" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "ace" }

  keep_score['player_points'] = players.length * 11
  keep_score['dealer_points'] = dealers.length * 11

  player.length.times do
    keep_score['player_points'] -= 10 if keep_score['player_points'] > 21
  end

  dealer.length.times do
    keep_score['dealer_points'] -= 10 if keep_score['dealer_points'] > 21
  end
end


def convert_aces(keep_score)
  players = keep_score['player_card_values'].select { |card| card == "ace" }
  dealers = keep_score['dealer_card_values'].select { |card| card == "ace" }

  keep_score['player_points'] = players.length * 11
  keep_score['dealer_points'] = dealers.length * 11

  keep_score['player_card_values'].select \
    { |value| value == 'ace' }.count.times do
    keep_score['player_points'] -= 10 if keep_score['player_points'] > 21
  end

  keep_score['dealer_card_values'].select \
    { |value| value == 'ace' }.count.times do
    keep_score['dealer_points'] -= 10 if keep_score['dealer_points'] > 21
  end
end

# ------------------




def convert_player_aces(keep_score)
  keep_score['player_card_values'].each do |card|
    if card == 'ace'
      keep_score['player_points'] += 11
    end
  end
  keep_score['player_card_values'].select \
    { |value| value == 'ace' }.count.times do
    keep_score['player_points'] -= 10 if keep_score['player_points'] > 21
  end
end
convert_player_aces(keep_score)

def convert_dealer_aces(keep_score)
  keep_score['dealer_card_values'].each do |card|
    if card == 'ace'
      keep_score['dealer_points'] += 11
    end
  end
  keep_score['dealer_card_values'].select \
    { |value| value == 'ace' }.count.times do
    keep_score['dealer_points'] -= 10 if keep_score['dealer_points'] > 21
  end
end
convert_dealer_aces(keep_score)