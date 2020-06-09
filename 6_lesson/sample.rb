def prompt(msg)
  puts "=> #{msg}"
end

loop do 
  prompt "Select a number: "
  number = gets.chomp.to_f
  p number
  break if number % 1 == 0
end


def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Player, choose a square: #{joinor(empty_squares(brd))}:"
    square = gets.chomp.to_i
    prompt "Square is #{square}"
    break if ((empty_squares(brd).include?(square)) && (square % 1 == 0))
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end