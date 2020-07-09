SUITS = ['H', 'D', 'S', 'C']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

BLACKJACK = 21
DEALER_HITS_UNTIL = 17

score = { 'player_total' => 0, \
          'dealer_total' => 0, \
          'player_wins' => 0, \
          'dealer_wins' => 0, \
          'tie_games' => 0 }

# Change how many rounds you'd like to play below:
rounds = { 'rounds_played' => 0, \
           'rounds_needed_to_win' => 2 }

bust_checker = { 'player_busts' => false, \
                 'dealer_busts' => false }

def prompt(msg)
  puts msg.to_s
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0 # J, Q, K
             10
           else
             value.to_i
           end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > BLACKJACK
  end

  sum
end

def busted?(cards)
  total(cards) > BLACKJACK
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > BLACKJACK
    :player_busted
  elsif dealer_total > BLACKJACK
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def update_score_end_of_round(dealer_cards, player_cards, score, rounds)
  result = detect_result(dealer_cards, player_cards)
  rounds['rounds_played'] += 1

  case result
  when :player_busted
    score['dealer_wins'] += 1
  when :dealer_busted
    score['player_wins'] += 1
  when :player
    score['player_wins'] += 1
  when :dealer
    score['dealer_wins'] += 1
  when :tie
    score['tie_games'] += 1
  end
end

def display_score(score)
  prompt "The player has #{score['player_wins']} wins."
  prompt "The dealer has #{score['dealer_wins']} wins."
  prompt "There have been #{score['tie_games']} ties."
end

def display_winner(score, rounds)
  if score['player_wins'] == rounds['rounds_needed_to_win']
    prompt "Player wins the game!"
  elsif score['dealer_wins'] == rounds['rounds_needed_to_win']
    prompt "Dealer wins the game!"
  end
end

def play_again?(rounds, score)
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')

  if answer.downcase.start_with?('y')
    rounds['rounds_played'] = 0
    score['player_wins'] = 0
    score['dealer_wins'] = 0
    score['tie_games'] = 0
  end
end

def display_bust(dealer_cards, player_cards, score, rounds)
  if bust_checker['player_busts'] == true

    display_result(dealer_cards, player_cards)
    update_score_end_of_round(dealer_cards, player_cards, score, rounds)
    display_score(score)

    prompt "Player busts round: #{rounds}"
    prompt "Player total: #{score['player_total']}"
    prompt "Dealer total: #{score['dealer_total']}"
  end
end

loop do
  system('clear') || system('cls')
  prompt "Welcome to Twenty-One!"

  until (score['player_wins'] == rounds['rounds_needed_to_win']) || \
        (score['dealer_wins'] == rounds['rounds_needed_to_win'])
    sleep 3
    system('clear') || system('cls')
    prompt "Welcome to round #{rounds['rounds_played'] + 1}!"
    puts "  "
    prompt "Player has #{score['player_wins']} wins"
    prompt "Dealer has #{score['dealer_wins']} wins"
    prompt "There have been #{score['tie_games']} ties"
    sleep 3

    # initialize vars
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    # initial deal
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    # initalize score vars
    player_total = total(player_cards)
    dealer_total = total(dealer_cards)

    prompt "  "
    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have: #{player_cards[0]} and #{player_cards[1]}, " \
           "for a total of #{player_total}."

    # player turn
    loop do
      player_turn = nil
      loop do
        prompt "  "
        prompt "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        player_total = total(player_cards)
        system('clear') || system('cls')

        prompt "You chose to hit!"
        prompt "Your cards are now: #{player_cards}"
        prompt "Your total is now: #{player_total}"
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    if busted?(player_cards)
      display_result(dealer_cards, player_cards)
      update_score_end_of_round(dealer_cards, player_cards, score, rounds)
      display_score(score)
      bust_checker['player_busts'] = true

      prompt "Player total: #{player_total}"
      prompt "Dealer total: #{dealer_total}"

      if score['player_wins'] < rounds['rounds_needed_to_win'] && \
         score['dealer_wins'] < rounds['rounds_needed_to_win']
        player_total = 0
        dealer_total = 0
        next
      elsif score['player_wins'] == rounds['rounds_needed_to_win'] || \
            score['dealer_wins'] == rounds['rounds_needed_to_win']
        play_again?(rounds, score) ? next : break
      end
    else
      prompt "You stayed at #{player_total}"
      puts "  "
    end

    # dealer turn
    prompt "Dealer turn..."

    loop do
      break if dealer_total >= DEALER_HITS_UNTIL

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    if busted?(dealer_cards)
      prompt "Dealer total is now: #{dealer_total}"
      display_result(dealer_cards, player_cards)
      update_score_end_of_round(dealer_cards, player_cards, score, rounds)
      display_score(score)
      bust_checker['dealer_busts'] = true

      if score['player_wins'] < rounds['rounds_needed_to_win'] && \
         score['dealer_wins'] < rounds['rounds_needed_to_win']
        player_total = 0
        dealer_total = 0
        next
      elsif score['player_wins'] == rounds['rounds_needed_to_win'] || \
            score['dealer_wins'] == rounds['rounds_needed_to_win']
        play_again?(rounds, score) ? next : break
      end
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    # both player and dealer stays - compare cards!
    puts "=============="
    prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
    prompt "Player has #{player_cards}, for a total of: #{player_total}"
    puts "=============="

    display_result(dealer_cards, player_cards)
    update_score_end_of_round(dealer_cards, player_cards, score, rounds)
    display_score(score)
    display_winner(score, rounds)
    prompt "  "
    prompt "This is the end of round #{rounds['rounds_played']}"
    sleep 3
  end

  player_total = 0
  dealer_total = 0

  unless bust_checker['player_busts'] == true || \
         bust_checker['dealer_busts'] == true
    answer = play_again?(rounds, score)
  end

  break unless answer == 'y'
end

system('clear') || system('cls')
prompt "Thank you for playing Twenty-One! Good bye!"
