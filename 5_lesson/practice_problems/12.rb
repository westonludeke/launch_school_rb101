# Given the following data structure, and without using the Array#to_h method, write some code that will return a hash where the key is the first item in each sub array and the value is the second item.

arr = [
  [:a, 1],
  ['b', 'two'],
  ['sea', {c: 3}],
  [{a: 1, b: 2, c: 3, d: 4}, 'D']
]

# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
hash = Hash[arr.map {|key, value| [key, value]}]
p hash

# Answer taken from: https://stackoverflow.com/questions/39567/what-is-the-best-way-to-convert-an-array-to-a-hash-in-ruby