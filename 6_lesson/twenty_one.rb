# Assignment: Twenty-One

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']

face_values = ['hearts', 'diamonds', 'club', 'spade']

player_cards = []
dealer_cards = []
remaining_cards = []

player_cards_total_value = 0
dealer_cards_total_value = 0

# Create Deck of all Cards
face_values.each do |val|
  i = 0
  until i == cards.length do 
    remaining_cards << [val, cards[i]]
    i += 1
  end
end
# Shuffle the deck
shuffled_cards = remaining_cards.shuffle!
p "The deck contains #{remaining_cards.length} cards."
player_cards << remaining_cards.pop
dealer_cards << remaining_cards.pop

p "The player has: #{player_cards}"
p "The dealer has: #{dealer_cards}"

# Calculate points for player
player_point = player_cards[0][1]

# if player_point.is_a? Integer
#   player_cards_total_value += player_point
# elsif player_point == 'jack' || player_point == 'queen' || player_point == 'king'
#   player_cards_total_value += 10
# elsif player_point == 'ace'
#   player_cards_total_value += 11
# end

if player_point == 'ace' 
  if player_cards_total_value + 11 <= 21
    player_cards_total_value += 11
  else
    player_cards_total_value += 1
  end
elsif player_point == 'jack' || player_point == 'queen' || player_point == 'king'
  player_cards_total_value += 10
elsif  player_point.is_a? Integer
  player_cards_total_value += player_point
end


# Calculate points for dealer
dealer_point = dealer_cards[0][1]

if dealer_point == 'ace'
  if dealer_cards_total_value + 11 <= 21
    dealer_cards_total_value += 11
  else
    dealer_cards_total_value += 1
  end
elsif dealer_point == 'jack' || dealer_point == 'queen' || dealer_point == 'king'
  dealer_cards_total_value += 10
elsif dealer_point.is_a? Integer
  dealer_cards_total_value += dealer_point
end

p "Player you have a #{player_cards_total_value} and the dealer has a #{dealer_cards_total_value}."
p "The deck now contains #{remaining_cards.length} cards."  


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

You start with a normal 52-card deck consisting of the 4 suits (hearts, diamonds, clubs, and spades), and 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace).

=end