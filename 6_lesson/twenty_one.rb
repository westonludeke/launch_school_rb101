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

def shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)
  #p "--------------------------"
  deck_of_cards = deck_of_cards.shuffle!
  #puts "Deck of cards after shuffling..."
  #p deck_of_cards
  player_hand << deck_of_cards.pop
  dealer_hand << deck_of_cards.pop
  #p "player hand is #{player_hand}"
  #p "dealer hand is #{dealer_hand}"
end
shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)

def get_current_card_value(player_hand, dealer_hand, keep_score)
  keep_score['player_current_card_value'] = player_hand[0][1]
  keep_score['dealer_current_card_value'] = dealer_hand[0][1]
  player_hand.shift
  dealer_hand.shift
end
get_current_card_value(player_hand, dealer_hand, keep_score)

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

def convert_face_cards_to_ten(keep_score)
  if keep_score['player_current_card_value'] == 'jack' || \
     keep_score['player_current_card_value'] == 'queen' || \
     keep_score['player_current_card_value'] =='king' 
    keep_score['player_hand_points'] += 10
  end

  if
    keep_score['dealer_current_card_value'] == 'jack' || \
     keep_score['dealer_current_card_value'] == 'queen' || \
     keep_score['dealer_current_card_value'] =='king' 
    keep_score['dealer_hand_points'] += 10
  end
end
convert_face_cards_to_ten(keep_score)

def add_integer_points(keep_score) 
  if keep_score['player_current_card_value'].is_a? Integer
    keep_score['player_hand_points'] += keep_score['player_current_card_value']
  end

  if keep_score['dealer_current_card_value'].is_a? Integer
    keep_score['dealer_hand_points'] += keep_score['dealer_current_card_value']
  end
end
add_integer_points(keep_score)

p keep_score

def alert_cards(keep_score)
  p "You drew a: #{keep_score['player_current_card_value']} " \
  "and the dealer drew a: #{keep_score['dealer_current_card_value']}." \
end
alert_cards(keep_score)

def player_hits(keep_score, deck_of_cards, player_hand, dealer_hand)
  puts "Drawing a new card now..."
  shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)
  get_current_card_value(player_hand, dealer_hand, keep_score)
  convert_ace_to_one_or_eleven(keep_score)
  convert_face_cards_to_ten(keep_score)
  add_integer_points(keep_score)
  alert_cards(keep_score)
  p keep_score
end
player_hits(keep_score, deck_of_cards, player_hand, dealer_hand)


# def update_with_newly_drawn_card_values(keep_score)
#   keep_score['player_current_card_value'] = player_hand[0][1]
#   keep_score['dealer_current_card_value'] = dealer_hand[0][1]
# end

# def ask_player_next_move(keep_score, deck_of_cards, player_hand, dealer_hand)
#   loop do 
#     puts "Would you like to hit or stay?"
#     answer = gets.chomp
#     puts "You have decided to #{answer}"
#     shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)
#     p keep_score
#     get_current_card_value(player_hand, dealer_hand, keep_score)
#     p keep_score
#     alert_cards(keep_score)
#     break if answer == 'stay' || answer == 's' #|| busted?
#   end
# end
# ask_player_next_move(keep_score, deck_of_cards, player_hand, dealer_hand)






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