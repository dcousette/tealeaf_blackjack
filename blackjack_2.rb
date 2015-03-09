def calculate_total(cards) #[["H", "2"], ["D, K"]]...
  card_values_array = cards.map {|card| card[1] }
  total = 0 
  
  card_values_array.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else 
      total += value.to_i
    end
  end
  
  #correct for aces
  card_values_array.select {|value| value == "A"}.count.times do 
    total -= 10 if total > 21  
  end
  
  total
end 

#create deck 
deck = []
suits = ['H', 'D', 'C', 'S']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'K', 'Q', 'J', 'A']

deck = suits.product(cards)
deck.shuffle!

#deal cards 
my_cards = []
dealer_cards = []

my_cards << deck.pop
dealer_cards << deck.pop
my_cards << deck.pop
dealer_cards << deck.pop

my_cards_total = calculate_total(my_cards)
dealer_cards_total = calculate_total(dealer_cards)

puts "Welcome to Blackjack!"
puts "Your cards are: #{my_cards[0]} and #{my_cards[1]}. For a total of: #{my_cards_total}"
puts "The Dealer's cards: #{dealer_cards[0]} and #{dealer_cards[1]}. For a total of: #{dealer_cards_total}"

if my_cards_total == 21
  puts "Congratulations you lucky dog! You've got Blackjack!"
end 

while my_cards_total < 21
  puts "What would you like to do: Hit(1)? or Stay(2)?"
  hit_or_stay = gets.chomp
  
  if !["1", "2"].include?(hit_or_stay)
    puts "Uh... yeah... please enter '1' or '2' friendo... "
    next 
  end
  
  if hit_or_stay == "2"
    puts "You chose to stay..."
    puts "Your score is: #{my_cards_total}"
    break
  end 
  
  new_card = deck.pop
  my_cards << new_card
  my_cards_total = calculate_total(mycards)
  puts "You were dealt a: #{new_card}"
  puts "Your score is: #{my_cards_total}"
end

if my_cards_total > 21 
  puts "Sorry partner, you've busted! Loser."
  exit 
end

#dealer turn 
if dealer_cards_total == 21
  puts "Dealer's got Blackjack! so... You lose!"
  exit
end 

while dealer_cards_total < 17 
  new_card = deck.pop
  puts "Dealer was dealt a: #{new_card}"
  dealer_cards << new_card
  dealer_cards_total = calculate_total(dealer_cards)
  puts "The dealer's score is: #{dealer_cards_total}"
  
  if dealer_cards_total > 21 
    puts "Dealer busts! YOU... WIN!!!"
    exit
  end 
end 

#compare cards 
puts "Your cards are:"
my_cards.each do |card|
  puts "=> #{card}"
end 

puts "The dealer's cards are:"
dealer_cards.each do |card|
  puts "=> #{card}"
end

if my_cards_total > dealer_cards_total
  puts "Oh... you win..."
elsif dealer_cards_total > my_cards_total 
  puts "DEALER WINS! So sorry, you lost. again."
else
  puts "It's a tie."
end 
exit 
