def calculate_total(cards) #[["H", "2"], ["D, K"]]...
  arr = cards.map {|a| a[1] }
  total = 0 
  
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else 
      total += value.to_i
    end
  end
  
  #correct for aces
  arr.select {|a| a == "A"}.count.times do 
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
mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

mycards_total = calculate_total(mycards)
dealercards_total = calculate_total(dealercards)

puts "Welcome to Blackjack!"
puts "Your cards are: #{mycards[0]} and #{mycards[1]}. For a total of: #{mycards_total}"
puts "The Dealer's cards: #{dealercards[0]} and #{dealercards[1]}. For a total of: #{dealercards_total}"

if mycards_total == 21
  puts "Congratulations you lucky dog! You've got Blackjack!"
end 

while mycards_total < 21
  puts "What would you like to do: Hit(1)? or Stay(2)?"
  hit_or_stay = gets.chomp
  
  if !["1", "2"].include?(hit_or_stay)
    puts "Uh... yeah... please enter '1' or '2' friendo... "
    next 
  end
  
  if hit_or_stay == "2"
    puts "You chose to stay..."
    puts "Your score is: #{mycards_total}"
    break
  end 
  
  new_card = deck.pop
  mycards << new_card
  mycards_total = calculate_total(mycards)
  puts "You were dealt a: #{new_card}"
  puts "Your score is: #{mycards_total}"
end

if mycards_total > 21 
  puts "Sorry partner, you've busted! Loser."
  exit 
end

#dealer turn 
if dealercards_total == 21
  puts "Dealer's got Blackjack! so... You lose!"
  exit
end 

while dealercards_total < 17 
  new_card = deck.pop
  puts "Dealer was dealt a: #{new_card}"
  dealercards << new_card
  dealercards_total = calculate_total(dealercards)
  puts "The dealer's score is: #{dealercards_total}"
  
  if dealercards_total > 21 
    puts "Dealer busts! YOU... WIN!!!"
    exit
  end 
end 

#compare cards 
puts "Your cards are:"
mycards.each do |card|
  puts "=> #{card}"
end 

puts "The dealer's cards are:"
dealercards.each do |card|
  puts "=> #{card}"
end

if mycards_total > dealercards_total
  puts "Oh... you win..."
elsif dealercards_total > mycards_total 
  puts "DEALER WINS! So sorry, you lost. again."
else
  puts "It's a tie."
end 
exit 
