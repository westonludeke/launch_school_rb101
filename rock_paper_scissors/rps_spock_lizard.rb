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

@player_score = 0
@computer_score = 0
def display_results(player, computer)
  if win?(player, computer)
    @player_score += 1
    prompt("You won! You now have #{@player_score} points!")
  elsif win?(computer, player)
    @computer_score += 1
    prompt("Computer won! The computer now has #{@computer_score} points.")
  else
    prompt("It's a tie game!. You remain at #{@player_score} points.")
    prompt("The computer remains at #{@computer_score} points.")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player_choice = Kernel.gets.chomp

    if player_choice.downcase.start_with?('r')
      choice = "rock"
    elsif player_choice.downcase.start_with?('p')
      choice = "paper"
    elsif player_choice.downcase.start_with?('sc')
      choice = "scissors"
    elsif player_choice.downcase.start_with?('sp')
      choice = "spock"
    elsif player_choice.downcase.start_with?('l')
      choice = "lizard"
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  display_results(choice, computer_choice)

  prompt("You chose #{choice}. The computer chose #{computer_choice}")

  prompt('Do you want to play again?')
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing! You finished with #{@player_score} total points.")
prompt("The computer finished with #{@computer_score} total points. Good bye!")
