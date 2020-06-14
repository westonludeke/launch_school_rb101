# Twenty-One
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
card_suits = ['hearts', 'diamonds', 'club', 'spade']

keep_score = {'player_score_current_hand' => 0, 'dealer_score_current_hand' => 0, \
              'player_game_score' => 0, 'dealer_game_score' => 0}

player_hand = []
dealer_hand = []
deck_of_cards = []
player_current_card_value = []
dealer_current_card_value = []

# player_hand_total_value = 0
# dealer_hand_total_value = 0

# Create Deck of all Cards
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
p deck_of_cards

# Shuffle the deck and deal cards
def shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)
  deck_of_cards = deck_of_cards.shuffle!
  p "The deck contains #{deck_of_cards.length} cards to start."
  player_hand << deck_of_cards.pop
  dealer_hand << deck_of_cards.pop

  p "The player has: #{player_hand}"
  p "The dealer has: #{dealer_hand}"
end
shuffle_and_deal(deck_of_cards, player_hand, dealer_hand)

# Getting the value of player and dealer's currently dealt card
def get_current_card_value(player_hand, dealer_hand, player_current_card_value, dealer_current_card_value) 
  player_current_card_value << player_hand[0][1]
  dealer_current_card_value << dealer_hand[0][1]
  p player_current_card_value
end
get_current_card_value(player_hand, dealer_hand, player_current_card_value, dealer_current_card_value)

p player_current_card_value[0]
p dealer_current_card_value[0]

def calculate_player_hand_points(player_current_card_value, keep_score)
  if player_current_card_value[0] == 'ace' 
    if keep_score['player_score_current_hand'] + 11 <= 21
      keep_score['player_score_current_hand'] += 11
    else
      keep_score['player_score_current_hand'] += 1
    end
  elsif player_current_card_value[0] == 'jack' || player_current_card_value[0] == 'queen' || player_current_card_value[0] == 'king'
    keep_score['player_score_current_hand'] += 10
  elsif  player_current_card_value[0].is_a? Integer
    keep_score['player_score_current_hand'] += player_current_card_value[0]
  else
    p "invalid"
  end
  p keep_score['player_score_current_hand']
end
calculate_player_hand_points(player_current_card_value, keep_score)

p keep_score['player_score_current_hand']


def calculate_dealer_hand_points(dealer_current_card_value, keep_score)
  if dealer_current_card_value[0] == 'ace' 
    if keep_score['dealer_score_current_hand'] + 11 <= 21
      keep_score['dealer_score_current_hand'] += 11
    else
      keep_score['dealer_score_current_hand'] += 1
    end
  elsif dealer_current_card_value[0] == 'jack' || dealer_current_card_value[0] == 'queen' || dealer_current_card_value[0] == 'king'
    keep_score['dealer_score_current_hand'] += 10
  elsif  dealer_current_card_value[0].is_a? Integer
    keep_score['dealer_score_current_hand'] += dealer_current_card_value[0]
  else
    p "invalid"
  end
  p keep_score['dealer_score_current_hand']
end
calculate_dealer_hand_points(dealer_current_card_value, keep_score)

p keep_score['dealer_score_current_hand']



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