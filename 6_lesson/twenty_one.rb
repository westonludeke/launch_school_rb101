# Twenty-One

=begin ---- TO-DO LIST ----
  
1. Stop playing once player busts

=end


card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'clubs', 'spades']

keep_score = { 'player_cards' => [], \
               'dealer_cards' => [], \
               'player_card_values' => [], \
               'dealer_card_values' => [], \
               'player_points' => 0, \
               'dealer_points' => 0, \
               'player_move' => '', \
               'dealer_move' => '', \
               'end_game' => false }

deck_of_cards = []

# ---- BEGINNING SETUP LOOP ----
def welcome
  system('clear') || system('cls')
  puts "Welcome to Twenty-One!"
  puts "The dealer is shuffling the deck and will soon hand out two cards each."
  # sleep 3
  system('clear') || system('cls')
end
welcome

def create_deck(card_suits, card_values, deck_of_cards)
  card_suits.each do |val|
    i = 0
    until i == card_values.length
      deck_of_cards << [val, card_values[i]]
      i += 1
    end
  end
end
create_deck(card_suits, card_values, deck_of_cards)

def shuffle!(deck_of_cards)
  deck_of_cards.shuffle!
end

def deal_first_two_cards_to_each_user(deck_of_cards, keep_score)
  2.times do
    shuffle!(deck_of_cards)
    keep_score["player_cards"] << deck_of_cards.pop
    keep_score["dealer_cards"] << deck_of_cards.pop
  end
end
deal_first_two_cards_to_each_user(deck_of_cards, keep_score)

# ---- FROM USER LOOPS / DEAL ONE ADDITIONAL CARD ----
def player_dealt_one_card(keep_score, deck_of_cards)
  shuffle!(deck_of_cards)
  keep_score["player_cards"] << deck_of_cards.pop
end
#p keep_score

def dealer_dealt_one_card(keep_score, deck_of_cards)
  shuffle!(deck_of_cards)
  keep_score["dealer_cards"] << deck_of_cards.pop
end

# ---- SHOW CARDS AND CONVERT FACE CARDS ----
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

#p keep_score

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


# ---- PLAYER LOOP ----
def show_player_all_cards(keep_score)
  # system('clear') || system('cls')
  i = 1
  while i < keep_score["player_cards"].length
    keep_score["player_cards"].each do |card|
      puts "You have a #{card[1]} of #{card[0]}"
      i += 1
    end
  end
end
show_player_all_cards(keep_score)

def show_dealer_first_card(keep_score)
  puts "The dealer has a #{keep_score['dealer_cards'][0][1]} of "\
  "#{keep_score['dealer_cards'][0][0]} " \
  "and #{keep_score['player_cards'].length - 1} unknown cards."
end
show_dealer_first_card(keep_score)

def show_dealer_all_cards(keep_score)
  i = 1
  while i < keep_score["dealer_cards"].length
    keep_score["dealer_cards"].each do |card|
      puts "The dealer has a #{card[1]} of #{card[0]}"
      i += 1
    end
  end
end

p keep_score


# ---- SCORE CHECK SECTION ----
def display_tie_game(keep_score)
  if keep_score['player_points'] == 21 && keep_score['dealer_points'] == 21
    keep_score['player_move'] = 'tie'
    keep_score['dealer_move'] = 'tie'
    puts "Tie game!"
  end
end

def display_dealer_blackjack(keep_score)
  if keep_score['dealer_points'] == 21
    keep_score['dealer_move'] = 'blackjack'
  end
end

def busted(keep_score)
  if keep_score['player_points'] > 21
    keep_score['player_move'] = 'bust'
    puts "Bust! You lose player. Better luck next time!" 

  elsif keep_score['dealer_points'] > 21
    keep_score['dealer_move'] = 'bust'
  end
end

def score_check_player_turn(keep_score)
  display_tie_game(keep_score)
  busted(keep_score)

  if keep_score['player_points'] == 21
    keep_score["player_move"] = 'win'
  elsif keep_score['dealer_points'] == 21
    keep_score["player_move"] = 'lose'
  else
    keep_score["player_move"] = ''
  end
end
score_check_player_turn(keep_score)

def dealer_wins(keep_score) 
  if keep_score['dealer_points'] >= 17 && keep_score['dealer_move'] == ''
    if keep_score['player_points'] < keep_score['dealer_points']
      keep_score['dealer_move'] = 'win'
    else keep_score['player_points'] > keep_score['dealer_points']
      keep_score['dealer_move'] = 'lose'
    end
  end
end

def score_check_dealer_turn(keep_score)
  #display_tie_game(keep_score)
  display_dealer_blackjack(keep_score)
  busted(keep_score)
  dealer_wins(keep_score)
end

def display_winner_dealer_loop(keep_score)
  if keep_score['dealer_move'] == 'tie'
    puts "Tie game!"
  elsif keep_score['dealer_move'] == 'blackjack'
    puts "Blackjack! The dealer has won the game!"
  elsif keep_score['dealer_move'] == 'win'
    puts "The dealer wins! Try again player"
  elsif keep_score['dealer_move'] == 'lose'
   puts 'You win player!'
  elsif keep_score['dealer_move'] == 'bust'
    puts "The dealer busts! You win player!"
  end
end

def display_score_update(keep_score)
  if keep_score["player_move"] == 'tie'
    puts "It's a tie game!"
  elsif keep_score["player_move"] == 'win'
    puts "Blackjack! The player wins!"
  elsif keep_score["player_move"] == 'lose'
    puts "The dealer has Blackjack! Sorry player, you lose."
  elsif keep_score["player_move"] == 'bust'
    puts "Sorry player, you've busted!"
  end
end
display_score_update(keep_score)

def end_game_check(keep_score)
  if keep_score["player_move"] != ''
    keep_score['end_game'] = true
    puts "Game over!"
  end
end
end_game_check(keep_score)

def show_player_points(keep_score)
  if keep_score["player_move"] == ''
    puts "You currently have #{keep_score['player_points']} points"
  end
end
show_player_points(keep_score)

def show_dealer_points(keep_score)
  puts "For a total of #{keep_score['dealer_points']} points"
end

# ----- ASK PLAYER NEXT MOVE & HIT LOOP ----
def player_hit_loop(keep_score, deck_of_cards)
  player_dealt_one_card(keep_score, deck_of_cards)
  get_current_player_card_value(keep_score)
  convert_player_face_cards(keep_score)
  convert_player_aces(keep_score)
  show_player_all_cards(keep_score)
  show_dealer_first_card(keep_score)
  score_check_player_turn(keep_score)
  show_player_points(keep_score)
  display_score_update(keep_score)
  end_game_check(keep_score)
end

#### CONVERT H TO HIT, S TO STAY. CHECK FOR INVALID ENTRIES.
def ask_player_next_move(keep_score, deck_of_cards)
  while keep_score["player_move"] == ''
    puts "Would you like to hit or stay?"
    keep_score["player_move"] = gets.chomp
    puts "You have decided to #{keep_score['player_move']}"

    if keep_score["player_move"] == 'hit'
      puts "Dealing a new card now..."
      sleep 2
      player_hit_loop(keep_score, deck_of_cards)
    elsif keep_score["player_move"] == 'stay'
      puts "Let's check the dealer's hand so far..."
    end
  end
end
ask_player_next_move(keep_score, deck_of_cards)

#p keep_score

def dealer_hit_loop(keep_score, deck_of_cards)
  ### CLEAR
  puts "-----"
  puts "The dealer is drawing another card now..."
  dealer_dealt_one_card(keep_score, deck_of_cards)
  get_current_player_card_value(keep_score)
  get_current_dealer_card_value(keep_score)
  convert_player_face_cards(keep_score)
  convert_dealer_face_cards(keep_score)
  convert_player_aces(keep_score)
  convert_dealer_aces(keep_score)
  show_dealer_all_cards(keep_score)
  show_dealer_points(keep_score)
  puts "--------"
  ## Player scores
  display_score_update(keep_score)
end

def dealer_stays(keep_score)
  #p "dealer stays"
  #p keep_score
  score_check_dealer_turn(keep_score)
  display_winner_dealer_loop(keep_score)
end

def dealer_under_seventeen_check(keep_score, deck_of_cards)
  if keep_score["player_move"] == 'stay'
    show_dealer_all_cards(keep_score)
    show_dealer_points(keep_score)
    score_check_dealer_turn(keep_score)
    
    while keep_score['dealer_points'] < 17
      # Draw another card
      dealer_hit_loop(keep_score, deck_of_cards)
    end

    if keep_score['dealer_points'] >= 17
      dealer_stays(keep_score)
    end
  end
end
dealer_under_seventeen_check(keep_score, deck_of_cards)

#p keep_score

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

You start with a normal 52-card deck consisting of the 4 card_suits \
(hearts, diamonds, clubs, and spades), \
and 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace).

=end
