# Game intro and explanation
puts '=> Welcome to the Rock, Paper, Scissors, Lizard, Spock game!'
puts '=> First to five points wins!'
puts '=> How it works:', "....for 'Rock' you can simply type 'R'"
puts "....for 'Paper' you can type 'P'"
puts "....for 'Scissors' you can type an 'X'"
puts "....for 'Spock' you can type 'S'"
puts "....and for 'Lizard' you can type 'L'"

VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'scissors' && second == 'paper') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'rock' && second == 'scissors')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won!')
  else
    prompt("It's a tie game!")
  end
end

player_score = ''
computer_score = ''

player_score = 0
computer_score = 0
loop do
  choice = ''
  loop do
    prompt("Make your selection: #{VALID_CHOICES.join(', ')}")
    player_choice = Kernel.gets.chomp

    if player_choice.downcase.start_with?('r')
      choice = 'rock'
    elsif player_choice.downcase.start_with?('p')
      choice = 'paper'
    elsif player_choice.downcase.start_with?('x')
      choice = 'scissors'
    elsif player_choice.downcase.start_with?('s')
      choice = 'spock'
    elsif player_choice.downcase.start_with?('l')
      choice = 'lizard'
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice. Please try again!")
    end
  end

  computer_choice = VALID_CHOICES.sample

  display_results(choice, computer_choice)

  if win?(choice, computer_choice)
    player_score += 1
  elsif win?(computer_choice, choice)
    computer_score += 1
  else
    prompt('The score will remain the same.')
  end

  prompt("You chose #{choice}. The computer chose #{computer_choice}")
  prompt("You now have #{player_score} points.")
  prompt("The computer has #{computer_score} points.")
  break if player_score == 5 || computer_score == 5

  prompt('Do you want to play again?')
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing! You finished with #{player_score} total points.")
prompt("The computer finished with #{computer_score} total points. Good bye!")
