# My answer may be technically cheating because I'm simply using Ruby's built-in method for generating a uuid

require 'securerandom'

def uuid
  SecureRandom.uuid
end

p uuid