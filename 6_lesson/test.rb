# Twenty-One

=begin ----TO-DO LIST----

1. Both users are initially dealt two cards. 
2. Player sees both of their cards.
3. Player can only see one of the dealers cards, all others are "unknown".
4. The value of Ace changes each time a new card is drawn.
  4b. When a new card is drawn, the value of ace is determined based on if all cards are >= 21.
5. Player continues to make choices until: 
  * Reaching 21, busts (i.e. over 21), or the player stays (i.e. under 21).
6. The dealer only draws more cards once the player stays.
7. If the dealer stays, compare points to see has the higher total.
8. The dealer hits until the dealer's points are at least 17.
9. If the dealer busts, the player wins.

=end

card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'clubs', 'spades']

keep_score = { 'player_cards_converted' => 0, \
               'dealer_cards_converted' => 0, \
               'player_cards' => [], \
               'dealer_cards' => [], \
               'player_card_value' => [], \
               'dealer_card_value' => [], \
               'player_points' => 0, \
               'dealer_points' => 0}

deck_of_cards = []

def welcome
  system('clear') || system('cls')
  puts "Welcome to Twenty-One!"
  puts "The dealer is shuffling the deck and will soon hand out two cards each."
  #sleep 3
  system('clear') || system('cls')
end
welcome

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

def shuffle!(deck_of_cards)
  deck_of_cards = deck_of_cards.shuffle!
end

def deal_first_two_cards_to_each_user(deck_of_cards, keep_score)
  shuffle!(deck_of_cards)
  keep_score["player_cards"] << deck_of_cards.pop
  keep_score["dealer_cards"] << deck_of_cards.pop
end
deal_first_two_cards_to_each_user(deck_of_cards, keep_score)
deal_first_two_cards_to_each_user(deck_of_cards, keep_score)

p keep_score

def show_player_their_two_cards(keep_score)
  puts "Player you have a #{keep_score["player_cards"][0][1]} of #{keep_score["player_cards"][0][0]} " \
  "and a #{keep_score["player_cards"][1][1]} of #{keep_score["player_cards"][1][0]}"
end
show_player_their_two_cards(keep_score)

def show_dealer_first_card(keep_score)
 puts "The dealer has a #{keep_score["dealer_cards"][0][1]} of #{keep_score["dealer_cards"][0][0]} " \
"and #{keep_score["player_cards"].length - 1} unknown cards."
end
show_dealer_first_card(keep_score)



def get_current_player_card_value(keep_score)
  #puts keep_score['player_cards'][keep_score['player_cards_converted']][1]
  keep_score['player_card_value'] = keep_score['player_cards'][keep_score['player_cards_converted']][1]
  keep_score['player_cards_converted'] += 1
end
get_current_player_card_value(keep_score)

p keep_score

def convert_ace_to_one_or_eleven(keep_score)
  if keep_score['player_card_value'] == 'ace'
    if keep_score['player_points'] + 11 <= 21
      keep_score['player_points'] += 11
    else
      keep_score['player_points'] += 1
    end
  end
end
convert_ace_to_one_or_eleven(keep_score)

p keep_score
#   if keep_score['player_card'] == 'ace'
#     if keep_score['player_hand_points'] + 11 <= 21
#       keep_score['player_hand_points'] += 11
#     else 
#       keep_score['player_hand_points'] += 1
#     end
#   end

#   if keep_score['dealer_current_card_value'] == 'ace'
#     if keep_score['dealer_hand_points'] + 11 <= 21
#       keep_score['dealer_hand_points'] += 11
#     else 
#       keep_score['dealer_hand_points'] += 1
#     end
#   end  
# end

# def face_card_check
# end

# def add_points
# end

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