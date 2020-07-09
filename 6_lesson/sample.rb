score = { 'player_total' => 0, \
          'dealer_total' => 0, \
          'player_wins' => 0, \
          'dealer_wins' => 0, \
          'tie_games' => 0 }

if busted?(player_cards)
  display_bust(dealer_cards, player_cards, score, rounds)

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

