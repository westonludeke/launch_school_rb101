# For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.

# Although my solutions below work, they are far more convoluted and less clean than the actual answers.

arr1 = [1, [2, 3], 4]

p arr1[1].map! { |x| x == 3 ? 4 : x }
p arr1

# ------------

arr2 = 
[
  {a: 1}, 
  {b: 2, c: [7, 6, 5], d: 4},
  3
]

p arr2.map! { |x| x == 3 ? 4 : x }

# ------------

hsh1 = 
{
  first: [1, 2, [3]]
}

p hsh1[:first][2].map! { |x| x == 3 ? 4 : x }
p hsh1

# ------------

hsh2 = 
{
  ['a'] => {a: ['1', :two, 3], b: 4},
  'b' => 5
}

p hsh2[['a']][:a].map! { |x| x == 3 ? 4 : x }
p hsh2