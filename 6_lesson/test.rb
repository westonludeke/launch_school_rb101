loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Would you like to play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
  
#--------------------------------------------------------


scoreboard = []
player_score = ''
computer_score = ''
loop do
  board = initialize_board
  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end
  display_board(board)

  if someone_won?(board)
    prompt "The #{detect_winner(board)} won!"
    scoreboard << detect_winner(board)
  else
    prompt "It's a tie!"
  end

  player_score = scoreboard.count("Player")
  computer_score = scoreboard.count("Computer")
  break if player_score == 5 || computer_score == 5
  prompt "The Player currently has #{player_score} wins vs the Computer's #{computer_score} wins."
  prompt "The next round will begin soon!"
  # Delay to show the current score before resetting the board
  sleep 5
  # prompt "Would you like to play again? (y or n)"
  # answer = gets.chomp
  # break unless answer.downcase.start_with?('y')
end

if player_score == 5
  prompt "The player has won! Good job."
elsif computer_score == 5
  prompt "The computer won. Better luck next time."
end 
prompt "Thanks for playing Tic Tac Toe! Goodbye!"