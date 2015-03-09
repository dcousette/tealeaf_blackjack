# rules & reqs 

# 1.  calculate the sum of card values and try to hit 21 (blackjack) 
# 2.  both player and dealer are dealt two cards to start the game
# 3.  face cards are worth 10 
# 4.  suit cards are worth their number value
# 5.  aces can be worth 11 or 1 (ex. a jack + ace = 21 (blackjack!))

# 6.  after dealt initial 2 cards, player goes first, can choose to 
#     "hit" or "stay".
# 7.  "hit" means to deal another card
#     if players cards sum > 21 player has busted and lost.
# 8.  if players sum == 21 then the player wins.
# 9.  if the sum < 21 player can choose to hit or stay again.
# 10. if a player hits then repeat the above 
# 11. if player stays, total value is saved and dealers turn.

# 12. dealer must hit until has 17 
# 13. if dealer busts, then player wins
# 14. if dealer stays, then we compare the sums if the two hands
#     between the player and the dealer. 
# 15. higher value wins     

#initial setup needs:
  #players (1 player and 1 dealer)
  #a way to store players totals 
  #deck of cards
    #4 suits (club, spade, hearts, diamond)
    #face cards for each suit number 2-10. value = #
    #1 ace card per suit. value = 11 or 1
    #3 suit cards per suit (king, queen, jack). value = 10
    
each player dealt 2 cards 

player prompted for input - what you like to do?
response = gets 

while gets == hit
  add card 
  tally score
    if > 21 
      bust
    elsif == 21
      blackjack
    end
  ask to hit or stay 
  gets 
end    
    
player_total is sum 

dealer turn 

dealer prompted for input - what wold you like to do?
response = random choice if > 17 else 'h'

while == hit
  add card 
  tally score
    if > 21 
      bust -lose 
    elsif == 21
      blackjack - win 
    end
  ask to hit or stay 
  gets 
end
  
compare scores .. who wins?
    
    
    
    
  
game is initialized - 2 cards dealt for each player
player goes first (prompted somehow.. puts...)

DECK = { "2H" => 2, "3H" => 3, "4H" => 4, "5H" => 5, "6H" => 6, "7H" => 7, "8H" => 8,
         "9H" => 9, "10H" => 10 }

# 2-10H
# 2-10S
# 2-10C
# 2-10D

# KQJ H
# KQJ S
# KQJ C
# KQJ D 
# AH
# AS
# AC
# AD


initialize_deck_method 
  need to get keys and values into the hash 
  limit literal insertion if possible
  
end

deal_method
  player_total += DECK.values.sample
end


initial deal happens
tell player their total 

loop until player_response == stay_method || bust_method || blackjack_method
puts ask player to choose hit or stay...
player_response = gets.chomp
  
  if player_response == "hit"
    hit_method
      player_total += (deal method) 1 card
    end
  else if player_response == "stay"
    stay_method
      player_total = sum up cards
    end
  end
  
  check_score_method 
    if player_total > 21 
      bust_method - you lose
    elsif player_total == 21 
      blackjack_method? - you win  
    else 
      player_total = sum and save player total for comparison to dealer later 
  end
  (if player total < 21 player can choose hit or stay again)
  
    