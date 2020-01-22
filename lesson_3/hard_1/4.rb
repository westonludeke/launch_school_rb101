
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split('.')
  integers = dot_separated_words.map(&:to_i)

  loop do
    if input_string.count('a-zA-Z') > 0
      puts 'Invalid! An IP address only contains numbers, not letters.'
      break
    else
      puts 'Success! IP addresses only contain numbers.'
    end

    if integers.all? { |n| n >= 0 && n < 256 }
      puts 'Your numbers are between 0 and 255 and may be valid IP numbers.'
    else
      puts 'Invalid! Each number should be between 0 and 255.'
      break
    end

    if integers.count == 4
      puts 'Your ip address contains the correct amount of numbers.'
    else
      puts 'An ip address should only show 4 numbers. Try again!'
    end
    break
  end
end

dot_separated_ip_address?('10.45.11.7')
