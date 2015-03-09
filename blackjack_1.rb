def initialize_deck 
  card_deck = {}
  suits     = ['H', 'D', 'C', 'S']
  suit_card_names = (2..10).map do |num|
    suits.map do |suit|
      num.to_s + suit
    end
  end
 
  faces = ['A', 'K', 'Q', 'J']
  face_card_names = faces.map do |num|
    suits.map do |suit|
      num.to_s + suit
    end
  end

  face_suits_array = suit_card_names.flatten + face_card_names.flatten
  face_suits_array.each do |k|
    card_deck[k] = " "
  end
  
  card_deck.each_pair do |k, v|
    card_deck[k] = k.to_i
    card_deck[k] = 10 if k.include?("K")
    card_deck[k] = 10 if k.include?("Q")
    card_deck[k] = 10 if k.include?("J")
    card_deck[k] = 1 if k.include?("A")
  end
  card_deck
end

def setup_players
  scores = {"player"=> 0, "dealer" => 0}
  scores
end

def deal_card(scores, name, deck)
  card = deck.keys.sample
  puts "#{name} Your card is: #{card}"
  scores[name] += deck[card]
end

def player_makes_choice(scores, name, deck)
  begin 
  puts "Hello #{name}, your sum is: #{scores[name]}"
  puts "What would you like to do: hit (Enter 'h')? or stay (Enter 's')?"
  player_choice = gets.chomp.downcase 
  if player_choice == "h"
    puts "---------#{name} Hits---------------"
    deal_card(scores, "player", deck)
  elsif player_choice == "s"
    puts "---------#{name} Stays-------------"
    break
  end
  end until scores[name] > 21 || scores[name] == 21
end

def dealer_makes_choice(scores, name, deck)
  begin 
  puts "Hello #{name}, your sum is: #{scores[name]}"
  puts "What would you like to do: hit (Enter 'h')? or stay (Enter 's')?"
  if scores["player"] > scores[name] 
    player_choice = 'h'
  else 
    player_choice = ['h','s'].sample 
  end
    if scores[name] < 17 
      player_choice = "h"
    end
  if player_choice == "h"  
    puts "---------#{name} Hits---------------"
    deal_card(scores, "dealer", deck)
  elsif player_choice == "s"
    puts "---------#{name} Stays-------------"
    break
  end
  end until scores[name] > 21 || scores[name] == 21
end

def check_score(scores, name)
  if scores[name] > 21 
    puts " BUST! #{name} loses... Ha Ha!"
    exit 
  elsif scores[name] == 21 
    puts "Blackjack! #{name} wins!!!" 
    exit
  end
end


puts "Welcome to the game!"
card_deck = initialize_deck
scores = setup_players
2.times { deal_card(scores, "player", card_deck) }
player_makes_choice(scores, "player", card_deck)
check_score(scores, "player")
2.times { deal_card(scores, "dealer", card_deck) }
puts "----- Dealer's Turn -----"
puts " "
dealer_makes_choice(scores, "dealer", card_deck)
check_score(scores, "dealer")

if scores["player"] > scores["dealer"]
  puts "Player Wins!!!"
else 
  puts "Dealer Wins!!!"
end 








