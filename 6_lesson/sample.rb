# ---- SCORING ----
def final_score
  if player_score == 5
    prompt "The player has won the game with #{player_score} wins" \
    "against the computer's #{computer_score} wins and #{tie_games} ties." \
    "Good job!"
  elsif computer_score == 5
    prompt "The computer has won the game with #{computer_score} victories" \
    "against your #{player_score} wins and #{tie_games} ties." \
    "Better luck next time."
  end
end

def beginning_round_prompt
  prompt "#{@total_score} rounds have been played so far."
  prompt "The #{@beginner} will start off this round!"
  sleep 3
end

def end_round_prompt
  # ---- SEE IF SOMEONE ONE THE ROUND
    if someone_won?(board)
      prompt "The #{detect_winner(board)} won this round!"
      @scoreboard << detect_winner(board)
    else
      @tie_games += 1
      prompt "It's a tie!"
    end

    @player_score = @scoreboard.count("Player")
    @computer_score = @scoreboard.count("Computer")
    @total_score = (@player_score + @computer_score + @tie_games)

  if @player_score < 5 && @computer_score < 5
    prompt "The Player currently has #{@player_score} wins." \
    "The computer has #{@computer_score} wins." \
    "There have been #{@tie_games} ties."
    prompt "The next round will begin soon!"
    who_starts_the_round?
  else
    prompt "We have game winner! Calculating final scores now..."
  end
  # Delay to show the current score before resetting the board
  sleep 5
end

def game_scoreboard
  @scoreboard = []
  @player_score = 0
  @computer_score = 0
  @tie_games = 0
end

def keeping_score
  # Keep going until either player or CPU reaches 5 wins
  until @player_score == 5 || @computer_score == 5
    beginning_round_prompt
    # show empty board at the beginning of the round
    board = initialize_board
    # Loop of selections
    if @beginner == 'Player'
      loop do
        display_board(board)

        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)
      end
    elsif @beginner == 'Computer'
      loop do
        display_board(board)

        computer_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        player_places_piece!(board)
        break if someone_won?(board) || board_full?(board)

        display_board(board)
      end
    end
    display_board(board)

    end_round_prompt    
  end
  # Final Score Method
  final_score
end
keeping_score