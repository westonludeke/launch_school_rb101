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

keep_score = { 'player_cards' => [], \
               'dealer_cards' => [], \
               'player_card_values' => [], \
               'dealer_card_values' => [], \
               'player_points' => 0, \
               'dealer_points' => 0, \
               'player_move' => ''}

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

def player_dealt_one_card(keep_score, deck_of_cards)
  shuffle!(deck_of_cards)
  keep_score["player_cards"] << deck_of_cards.pop
end

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

def show_player_all_cards(keep_score)
  #system('clear') || system('cls')
  i = 1
  while i < keep_score["player_cards"].length do #keep_score["player_cards"].length
    keep_score["player_cards"].each do |card|
      puts "You have a #{card[1]} of #{card[0]}"
      i += 1
    end
  end 
  #puts "Player you have a #{keep_score["player_cards"][0][1]} of #{keep_score["player_cards"][0][0]} " \
end

def get_current_player_card_value(keep_score)
  keep_score['player_cards'].each do |card|
    keep_score['player_card_values'] << card[1] 
  end
end
get_current_player_card_value(keep_score)

def get_current_dealer_card_value(keep_score)
  keep_score['dealer_cards'].each do |card|
    keep_score['dealer_card_values'] << card[1] 
  end
end
get_current_dealer_card_value(keep_score)

p keep_score

def convert_player_face_cards(keep_score)
  keep_score['player_card_values'].each do |card|
    if card == 'ace'
      if keep_score['player_points'] + 11 <= 21
        keep_score['player_points'] += 11
      else
        keep_score['player_points'] += 1
      end
    elsif card == "jack" || card == "queen" || card == "king"
      keep_score['player_points'] += 10
    elsif keep_score['player_points'].is_a? Integer
      keep_score['player_points'] += card
    end
  end
end
convert_player_face_cards(keep_score)

def convert_dealer_face_cards(keep_score)
  keep_score['dealer_card_values'].each do |card|
    if card == 'ace'
      if keep_score['dealer_points'] + 11 <= 21
        keep_score['dealer_points'] += 11
      else
        keep_score['dealer_points'] += 1
      end
    elsif card == "jack" || card == "queen" || card == "king"
      keep_score['dealer_points'] += 10
    elsif keep_score['dealer_points'].is_a? Integer
      keep_score['dealer_points'] += card
    end
  end
end
convert_dealer_face_cards(keep_score)

p keep_score

def player_hit_loop(keep_score, deck_of_cards)
  puts "Dealing a new card now..."
  player_dealt_one_card(keep_score, deck_of_cards)
  #sleep 5
  show_player_all_cards(keep_score)
end

def ask_player_next_move(keep_score, deck_of_cards)
  puts "Would you like to hit or stay?"
  keep_score["player_move"] = gets.chomp
  puts "You have decided to #{keep_score["player_move"]}"
  if keep_score["player_move"] != 'stay'
    player_hit_loop(keep_score, deck_of_cards)
  end
end

def score_check_player_turn(keep_score, deck_of_cards)
  if keep_score['player_points'] == 21 && keep_score['dealer_points'] == 21
    puts "It's a tie game!"
  elsif keep_score['player_points'] == 21
    puts "Blackjack! The player wins!"
  elsif keep_score['dealer_points'] == 21
    puts "The dealer has Blackjack! Sorry player, you lose."
  elsif keep_score['player_points'] > 21
    puts "Sorry player, you've busted!"
  else
    puts "You currently have #{keep_score['player_points']} points. "
    show_dealer_first_card(keep_score)
    ask_player_next_move(keep_score, deck_of_cards)
  end
end
score_check_player_turn(keep_score, deck_of_cards)

p keep_score
# def player_hits(keep_score, deck_of_cards)
#  player_dealt_one_card(keep_score)
# end




#   p keep_score
# end

# def game_loop(keep_score, deck_of_cards)
#   until busted(keep_score) == true || twenty_one_check(keep_score) == true
#     ask_player_next_move(keep_score, deck_of_cards, player_hand, dealer_hand)
#     if @answer == 'stay' 
#       stay_and_determine_winner(keep_score)
#     end
#     break if @answer == 'stay' || @answer == 's'
#     system('clear') || system('cls')
#     player_hits(keep_score, deck_of_cards, player_hand, dealer_hand)
#   end
# end
# game_loop(keep_score, deck_of_cards)

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