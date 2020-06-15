# Twenty-One
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'club', 'spade']

keep_score = { 'player_current_card_value' => '', \
               'dealer_current_card_value' => '', \
               'player_hand_points' => 0, \
               'dealer_hand_points' => 0, \
               'player_game_score' => 0, \
               'dealer_game_score' => 0}

player_hand = []
dealer_hand = []
deck_of_cards = []

def create_deck(card_suits, card_values, deck_of_cards)
  card_suits.each do |val|
    i = 0
    until i == card_values.length do 
      deck_of_cards << [val, card_values[i]]
      i += 1
    end
  end
end
create_deck(card_suits, card_values, deck_of_cards)
#p deck_of_cards

def shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)
  deck_of_cards = deck_of_cards.shuffle!
  p "The deck contains #{deck_of_cards.length} cards to start."
  player_hand << deck_of_cards.pop
  dealer_hand << deck_of_cards.pop

  p "The player has: #{player_hand}"
  p "The dealer has: #{dealer_hand}"
end
shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)

def get_current_card_value(player_hand, dealer_hand, keep_score)
  keep_score['player_current_card_value'] = player_hand[0][1]
  keep_score['dealer_current_card_value'] = dealer_hand[0][1]
end
get_current_card_value(player_hand, dealer_hand, keep_score)

p keep_score

def convert_ace_to_one_or_eleven(keep_score)
  if keep_score['player_current_card_value'] == 'ace'
    if keep_score['player_hand_points'] + 11 <= 21
      keep_score['player_hand_points'] += 11
    else 
      keep_score['player_hand_points'] += 1
    end
  elsif keep_score['dealer_current_card_value'] == 'ace'
    if keep_score['dealer_hand_points'] += 11 <= 21
      keep_score['dealer_hand_points'] += 11
    else keep_score['dealer_hand_points'] += 1
    end
  end  
end
convert_ace_to_one_or_eleven(keep_score)

def convert_face_cards_to_ten(keep_score)
  if keep_score['player_current_card_value'] == 'jack' || \
     keep_score['player_current_card_value'] == 'queen' || \
     keep_score['player_current_card_value'] =='king' 
    keep_score['player_hand_points'] += 10
  elsif 
    keep_score['dealer_current_card_value'] == 'jack' || \
     keep_score['dealer_current_card_value'] == 'queen' || \
     keep_score['dealer_current_card_value'] =='king' 
    keep_score['dealer_hand_points'] += 10
  end
end
convert_face_cards_to_ten(keep_score)

def add_integer_points(keep_score)
  if keep_score['player_current_card_value'].is_a? Integer
    keep_score['player_hand_points'] = keep_score['player_current_card_value']
  elsif 
    keep_score['dealer_current_card_value'].is_a? Integer
    keep_score['dealer_hand_points'] = keep_score['dealer_hand_points']
  end
end
add_integer_points(keep_score)

p keep_score
=begin Implementation Steps:

1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

You start with a normal 52-card deck consisting of the 4 card_suits (hearts, diamonds, clubs, and spades), and 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace).

=end