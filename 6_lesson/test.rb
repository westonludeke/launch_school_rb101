# Twenty-One

=begin ---- TODO LIST----

1. Store 21 and 17 as constants

2. Keep scores, first to 5 rounds wins the game

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

def welcome
  system('clear') || system('cls')
  puts "Welcome to Twenty-One!"
  puts "The dealer is shuffling the deck and will soon hand out two cards each."
  sleep 3
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

def player_dealt_one_card(keep_score, deck_of_cards)
  shuffle!(deck_of_cards)
  keep_score["player_cards"] << deck_of_cards.pop
end

def dealer_dealt_one_card(keep_score, deck_of_cards)
  shuffle!(deck_of_cards)
  keep_score["dealer_cards"] << deck_of_cards.pop
end

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

def convert_face_cards(keep_score)
  keep_score['player_points'] = 0
  keep_score['dealer_points'] = 0

  players = keep_score['player_card_values'].select \
            { |card| card == "jack" || card == "queen" || card == "king" }
  dealers = keep_score['dealer_card_values'].select \
            { |card| card == "jack" || card == "queen" || card == "king" }

  keep_score['player_points'] = players.length * 10
  keep_score['dealer_points'] = dealers.length * 10
end
convert_face_cards(keep_score)

def add_integer_points(keep_score)
  players = keep_score['player_card_values'].select \
            { |card| card.is_a? Integer }
  dealers = keep_score['dealer_card_values'].select \
            { |card| card.is_a? Integer }

  players.each { |num| keep_score['player_points'] += num }
  dealers.each { |num| keep_score['dealer_points'] += num }
end
add_integer_points(keep_score)

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

def show_player_all_cards(keep_score)
  system('clear') || system('cls')
  puts "Here's your cards player: "
  puts "------------------------"

  i = 1
  while i < keep_score["player_cards"].length
    keep_score["player_cards"].each do |card|
      puts "#{card[1]} of #{card[0]}"
      i += 1
    end
  end
  puts "                        "
end
show_player_all_cards(keep_score)

def show_dealer_first_card(keep_score)
  puts "Here's the dealers cards:"
  puts "------------------------"
  puts "#{keep_score['dealer_cards'][0][1]} of "\
  "#{keep_score['dealer_cards'][0][0]} "
  puts "1 unknown card."
  puts "                        "
end
show_dealer_first_card(keep_score)

def show_dealer_all_cards(keep_score)
  puts "                         "
  puts "Here's the dealer's cards:"
  puts "-------------------------"

  i = 1
  while i < keep_score["dealer_cards"].length
    keep_score["dealer_cards"].each do |card|
      puts "#{card[1]} of #{card[0]}"
      i += 1
    end
  end
  puts "                        "
end

def tie_game(keep_score)
  if keep_score['dealer_move'] == 'stay'
    if keep_score['player_points'] == keep_score['dealer_points']
      keep_score['dealer_move'] = 'tie'
    end
  end
end

def dealer_blackjack(keep_score)
  if keep_score['dealer_points'] == 21
    keep_score['dealer_move'] = 'blackjack'
    keep_score['end_game'] = true
  end
end

def busted(keep_score)
  if keep_score['player_points'] > 21
    keep_score['player_move'] = 'bust'
  elsif keep_score['dealer_points'] > 21
    keep_score['dealer_move'] = 'bust'
  end
end

def score_check_player_turn(keep_score)
  tie_game(keep_score)
  busted(keep_score)

  if keep_score['player_points'] == 21
    keep_score["player_move"] = 'win'
  elsif keep_score['dealer_points'] == 21
    keep_score["player_move"] = 'lose'
  end
end
score_check_player_turn(keep_score)

def display_score_update(keep_score)
  if keep_score["player_move"] == 'tie'
    puts "It's a tie game!"
  elsif keep_score["player_move"] == 'win'
    puts "Blackjack! The player wins!"
  elsif keep_score["player_move"] == 'lose'
    puts "The dealer has Blackjack! Sorry player, you lose."
  elsif keep_score["player_move"] == 'bust'
    puts "Sorry player. At #{keep_score['player_points']} points you've busted!"
  end
end
display_score_update(keep_score)

def dealer_win_or_lose(keep_score)
  if keep_score['dealer_points'] >= 17 && keep_score['dealer_move'] == 'stay'
    if keep_score['player_points'] < keep_score['dealer_points']
      keep_score['dealer_move'] = 'win'
      keep_score['end_game'] = true
    elsif keep_score['player_points'] > keep_score['dealer_points']
      keep_score['dealer_move'] = 'lose'
      keep_score['end_game'] = true
    end
  end
end

def end_game_check(keep_score)
  if keep_score['player_move'] != ''
    keep_score['end_game'] = true
  end
end
end_game_check(keep_score)

def clear_player_move(keep_score)
  if keep_score['player_points'] < 21 && keep_score["player_move"] == 'hit'
    keep_score["player_move"] = ''
  end
end

def show_player_points(keep_score)
  if keep_score["player_move"] == ''
    puts "Scoreboard:"
    puts "----------"
    puts "You currently have #{keep_score['player_points']} points"
    puts "                  "
  end
end
show_player_points(keep_score)

def show_dealer_points(keep_score)
  puts "Scoreboard:"
  puts "----------"
  puts "You currently have #{keep_score['player_points']} points"
  puts "The dealer has #{keep_score['dealer_points']} points"
  puts "        "
end

def player_hit_loop(keep_score, deck_of_cards)
  player_dealt_one_card(keep_score, deck_of_cards)
  get_current_card_value(keep_score)
  convert_face_cards(keep_score)
  add_integer_points(keep_score)
  convert_aces(keep_score)
  reduce_ace_to_one(keep_score)
  show_player_all_cards(keep_score)
  show_dealer_first_card(keep_score)
  score_check_player_turn(keep_score)
  clear_player_move(keep_score)
  show_player_points(keep_score)
  display_score_update(keep_score)
  end_game_check(keep_score)
end

def display_hit_or_stay(keep_score, deck_of_cards)
  system('clear') || system('cls')

  if keep_score["player_move"] == 'hit'
    puts "You have decided to #{keep_score['player_move']}"
    puts "Dealing a new card now..."
    sleep 2
    player_hit_loop(keep_score, deck_of_cards)
  elsif keep_score["player_move"] == 'stay'
    puts "You have decided to #{keep_score['player_move']}"
    puts "It's now the dealer's turn. " \
    "Let's check the dealer's hand so far..."
    sleep 2
  end
end

def ask_player_next_move(keep_score, deck_of_cards)
  while keep_score["player_move"] == ''
    puts "Would you like to hit or stay? (h or s)"
    answer = gets.chomp
    if answer.downcase == ('h') || answer.downcase == ('hit')
      keep_score["player_move"] = 'hit'
    elsif answer.downcase == ('s') || answer.downcase == ('stay')
      keep_score["player_move"] = 'stay'
    else
      puts "Sorry player, that's an invalid entry!"
      sleep 2
    end
    display_hit_or_stay(keep_score, deck_of_cards)
  end
end
ask_player_next_move(keep_score, deck_of_cards)

def dealer_hit_loop(keep_score, deck_of_cards)
  puts "The dealer is drawing another card now..."
  sleep 5
  system('clear') || system('cls')
  dealer_dealt_one_card(keep_score, deck_of_cards)
  get_current_card_value(keep_score)
  convert_face_cards(keep_score)
  add_integer_points(keep_score)
  convert_aces(keep_score)
  reduce_ace_to_one(keep_score)
  show_dealer_all_cards(keep_score)
  show_dealer_points(keep_score)
  display_score_update(keep_score)
end

def calculate_winner(keep_score)
  keep_score['dealer_move'] = 'stay'
  puts "The dealer has decided to stay."
  puts "                  "
  puts "Let's see if we have a winner. Calculating scores..."
  puts "                  "
  busted(keep_score)
  dealer_blackjack(keep_score)
  tie_game(keep_score)
  dealer_win_or_lose(keep_score)
end

def display_dealer_blackjack(keep_score)
  if keep_score['dealer_move'] == 'blackjack'
    puts "Blackjack! The dealer has won the game. Better luck next time!"
    keep_score['end_game'] = true
  end
end

def display_tie_game(keep_score)
  if keep_score['dealer_move'] == 'tie'
    puts "It's a tie game!"
    keep_score['end_game'] = true
  end
end

def display_winner_dealer_loop(keep_score)
  if keep_score['dealer_move'] == 'bust'
    puts "You win! The dealer busts with #{keep_score['dealer_points']} " \
    "points compared to your #{keep_score['player_points']}."
    keep_score['end_game'] = true

  elsif keep_score['dealer_move'] == 'win'
    puts "The dealer wins! The dealer's #{keep_score['dealer_points']} points" \
    " beats out your #{keep_score['player_points']} points."
    keep_score['end_game'] = true

  elsif keep_score['dealer_move'] == 'lose'
    puts "You win player! Your #{keep_score['player_points']} points " \
    "beats out the dealer's #{keep_score['dealer_points']} points."
    keep_score['end_game'] = true
  end
end

def dealer_under_seventeen_check(keep_score, deck_of_cards)
  if keep_score["player_move"] == 'stay'
    show_dealer_all_cards(keep_score)
    show_dealer_points(keep_score)

    while keep_score['dealer_points'] < 17
      dealer_hit_loop(keep_score, deck_of_cards)
    end

    if keep_score['dealer_points'] >= 17
      calculate_winner(keep_score)
      display_winner_dealer_loop(keep_score)
      display_dealer_blackjack(keep_score)
      display_tie_game(keep_score)
    end
  end
end
dealer_under_seventeen_check(keep_score, deck_of_cards)

def clear_hash(keep_score)
  keep_score['player_cards'] = []
  keep_score['dealer_cards'] = []
  keep_score['player_card_values'] = []
  keep_score['dealer_card_values'] = []
  keep_score['player_points'] = 0
  keep_score['dealer_points'] = 0
  keep_score['player_move'] = ''
  keep_score['dealer_move'] = ''
  keep_score['end_game'] = false
end

def place_cards_back_in_deck_and_shuffle(deck_of_cards, card_suits, card_values)
  deck_of_cards.clear
  create_deck(card_suits, card_values, deck_of_cards)
  shuffle!(deck_of_cards)
end

def play_again_loop(keep_score, deck_of_cards, card_suits, card_values)
  place_cards_back_in_deck_and_shuffle(deck_of_cards, card_suits, card_values)
  deal_first_two_cards_to_each_user(deck_of_cards, keep_score)
  get_current_card_value(keep_score)
  convert_face_cards(keep_score)
  add_integer_points(keep_score)
  convert_aces(keep_score)
  reduce_ace_to_one(keep_score)
  show_player_all_cards(keep_score)
  show_dealer_first_card(keep_score)
  show_player_points(keep_score)
  score_check_player_turn(keep_score)
  display_score_update(keep_score)
  end_game_check(keep_score)
  ask_player_next_move(keep_score, deck_of_cards)
  dealer_under_seventeen_check(keep_score, deck_of_cards)
end

def end_game_prompt(keep_score, deck_of_cards, card_suits, card_values)
  while keep_score['end_game'] == true
    puts "            "
    puts "Would you like to play again? (y or n)"
    answer = gets.chomp
    if answer.downcase == ('y') || answer.downcase == ('yes')
      puts "Next round coming up!"
      sleep 3
      clear_hash(keep_score)
      play_again_loop(keep_score, deck_of_cards, card_suits, card_values)
    else
      keep_score['end_game'] = ''
      puts "Thanks for playing Twenty One! Goodbye!"
    end
  end
end
end_game_prompt(keep_score, deck_of_cards, card_suits, card_values)
