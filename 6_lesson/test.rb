def joinor(arr, punc = ", ", or_and = "or")
  new_arr = []

  # Convert all integers in the array to a string
  arr.map! do |val|
    val.to_s
  end

  # Removes the last array item
  last = arr.pop

  if arr.length > 1
    arr.each do |value|
      new_arr << value + punc
    end
  else 
    arr.each do |value|
      new_arr << value + " "
    end
  end 

  if arr.length == 0
    new_arr << last
  else 
    new_arr << or_and + " " + last
  end

  new_arr.join("")
end

p joinor([1])
p joinor([1,2])
p joinor([1,2,3])