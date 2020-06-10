score_hash = {"player_score" => 0, "computer_score" => 0, "rounds_played" => 0}
@beginner = ''

p score_hash

def who_starts(score_hash)
  @beginner = if score_hash.length == 3
                'Player'
                p 'Player is beginner'
                score_hash["player_score"] += 1
                p score_hash["player_score"]
              else
                'Computer'
                p 'CPU is beginner'
              end
end
who_starts(score_hash)

p score_hash


# def update_score(score_hash, user, score)
#   if user == 'player'
#     p score_hash['player_score'] += 1
#   elsif user = 'computer'
#     p score_hash['computer_score'] += 1
#   end
# end
# update_score(score_hash, 'player', 1)
# update_score(score_hash, 'computer', 1)
# p score_hash

# player_score = score_hash["player_score"]
# p "player score is: #{player_score}"
# cpu_score = score_hash["computer_score"]
# p "computer score is #{cpu_score}"

# score_hash["player_score"]
# score_hash["computer_score"]
# score_hash["rounds_played"]