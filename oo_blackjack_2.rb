# abstraction 
# encapsulation 

class Card
  attr_accessor :suit, :face_value
  def initialize(suit, face_value)
    @suit = suit 
    @face_value = face_value
  end
  
  def to_s
    pretty_output
  end  
  
  def pretty_output
    "The #{face_value} of #{get_suit}"
  end 
  
  def get_suit 
    case suit 
      when 'H' then 'Hearts' 
      when 'S' then 'Spades'
      when 'C' then 'Clubs' 
      when 'D' then 'Diamonds'
    end 
  end 
end 

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    ['H', 'S', 'C', 'D'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'K', 'Q', 'J', 'A'].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    shuffle!
  end 
  
  def shuffle!
    cards.shuffle!
  end 
  
  def deal_one
    cards.pop  
  end
  
  def size
    cards.size
  end 
end

module Hand
  
  def total
    face_values = cards.map {|card| card.face_value }
    
    total = 0
    face_values.each do |value|
      if value == "A" 
        total += 11
      else
        total += ( value.to_i == 0 ? 10 : value.to_i)     
      end
    end 
    
    face_values.select {|value| value == "A"}.count.times do 
      break if total <= 21 
      total -= 10
    end
    total 
  end 
  
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card| 
      puts "=> #{card.to_s}"
    end 
    puts "=> Total: #{total}"
  end
  
  def add_card(new)
    cards << new 
  end
  
  def is_busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end
end 

class Player
  include Hand
  attr_accessor :name, :cards 
  def initialize(name)
    @name = name
    @cards = []
  end
  
  def show_flop
    show_hand
  end 
  
end 
  
class Dealer 
  attr_accessor :name, :cards
  include Hand 
  
  
  def initialize(name)
    @name = name
    @cards = []
  end
  
  def show_flop
    puts "-----#{name}'s Hand -----"
    puts "=> The first card is hidden."
    puts "=> The second card is: #{cards[1].to_s}"
  end
end 

class Blackjack
  attr_accessor :deck, :player, :dealer
  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17
  
  def initialize
    @deck = Deck.new
    @player = Player.new("Player")
    @dealer = Dealer.new("Dealer")
  end
  
  def set_player_name
    puts "What is your name?"
    player.name = gets.chomp
  end
  
  def deal_cards
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end
  
  def show_flop
    player.show_flop 
    dealer.show_flop 
  end
  
  def player_turn
    
    blackjack_or_busted?(player)
    
    while !player.is_busted?
      puts "What would you like to do? Hit (1) or Stay (2)?"
      response = gets.chomp 
      if !["1", "2"].include?(response) 
        puts "Please enter either 1 or 2!"
        next
      end
      
      if response == '2'
        puts "----#{player.name} chose to stay at #{player.total}-----."
        break
      end
      
      #hit
      new_card = deck.deal_one
      puts "Dealing card to #{player.name}: #{new_card}."
      player.add_card(new_card)
      puts "#{player.name}'s total is now: #{player.total}."
      blackjack_or_busted?(player)  
    end
  end 
  
  def blackjack_or_busted?(player_or_dealer)
    if player_or_dealer.total == Blackjack::BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry chump, the Dealer got Blackjack. #{player.name} lost... go home."
      elsif player_or_dealer.is_a?(Player)
        puts "You lucky dog! You've got Blackjack! #{player.name} won!"
      end 
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "The Dealer busted! #{player.name} wins!"
      elsif player_or_dealer.is_a?(Player)
        puts "#{player.name} busted!! #{player.name} is the biggest loser."
      end
      play_again?
    end
  end 
    
  def dealer_turn
    puts "----- Dealer's turn -----"
    blackjack_or_busted?(dealer)
  
    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal_one
      dealer.add_card(new_card)
      puts "#{dealer.name}'s total is now: #{dealer.total}."
      blackjack_or_busted?(dealer)
    end
    puts "----- Dealer stays at #{dealer.total} -----"
  end
  
  def who_won?
    if player.total > dealer.total
      puts "Congratulations #{player.name} you won!!!"
    elsif player.total < dealer.total 
      puts "Sorry, #{player.name} you lost..."
    else 
      puts "It's a tie."
    end
    play_again?
  end
  
  def play_again?
    puts ""
    puts "Would you like to play again? (1) Yes (2) Nope, I'm done :"
    if gets.chomp == '1'
      puts ""
      puts "Starting a new game..."
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start 
    else 
      puts "Goodbye!"
      exit
    end
  end
  
  def start
    set_player_name
    deal_cards
    show_flop 
    player_turn
    dealer_turn
    who_won?
    play_again?
  end

end 

game = Blackjack.new
game.start
