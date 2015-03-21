# blackjack is a card game. Two players (player and dealer) each are dealt 2 cards from a deck. The cards are ranked as 
# follows: all suit cards are based on number value, face cards are 10 points, aces are 11 or 1 point. 
# Once each player is dealt two cards to begin the game, the player goes first. Player can choose to either hit (take 1 card) or stay (to pass turn to 
# dealer). If either player gets 21 points they win (blackjack), over 21 is bust-lose, if neither player nor dealer bust or 
# blackjack, they compare hands to find the winner w highest point total under 21. If dealer total is less than 17 dealer must hit.

class Deck 
  attr_accessor :card_deck, :suits, :values
   
  def initialize
    self.card_deck = []
    self.suits = ['H', 'C', 'S', 'D']
    self.values = ['2', '3', '4', '5', '6', '7', '8', '9', 'K', 'Q', 'J', 'A']
    self.card_deck = suits.product(values)
    card_deck.map! {|card| Card.new(card[0],card[1])}
    card_deck.shuffle!
  end   
end 

class Player
  attr_accessor :name, :points, :cards_in_hand
  def initialize(name)
    self.name = name
    self.points = 0
    self.cards_in_hand = []
  end
  
  def sum_points
    total = 0
    sum = self.cards_in_hand.map do |card|
      card.value.to_i
    end 
    
    sum.each do |number|
      number = 10 if number == 0 
      total += number
    end
    #still need to correct for aces 
    total
  end
end 

class Card 
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end 
end 

class Game 
  attr_reader :game_deck
  def initialize
    @game_deck = Deck.new
    @player = Player.new("Player")
    @dealer = Player.new("Dealer")
  end 
  
  def opening_deal
    puts "Welcome to Blackjack!"
    2.times {deal_card(@player)}
    2.times {deal_card(@dealer)} 
  end 
  
  def deal_card(player)
    player.cards_in_hand << @game_deck.card_deck.pop
    puts "#{player.name}, your card is: #{player.cards_in_hand.last.value} of #{player.cards_in_hand.last.suit}"
  end 
  
  def choose_hit_or_stay(player)
    begin
      puts "#{player.name}, you currently have a score of: #{player.sum_points}."
      puts "What would you like to do? Hit (press H) or Stay (press S)?"
      response = gets.chomp.downcase
      if response == 'h'
        puts "You chose to hit!"
        deal_card(player)
      end
      if player.sum_points == 21
        puts "You win! Blackjack!"
        exit
      elsif player.sum_points > 21
        puts "Bust! You lose..."
        exit 
      end 
    end until response == 's' 
    puts "#{player.name} stays."
  end 
  
  def dealer_hit_or_stay(player)
    begin
      puts "#{player.name}, you currently have a score of: #{player.sum_points}."
      puts "What would you like to do? Hit (press H) or Stay (press S)?"
      response = ['h', 's'].sample
      if response == 'h'
        puts "You chose to hit!"
        deal_card(player)
      end
      if player.sum_points == 21
        puts "You win! Blackjack!"
        exit
      elsif player.sum_points > 21
        puts "Bust! You lose..."
        exit 
      end 
    end until response == 's'  
    puts "#{player.name} stays."
  end  
  
  def compare_scores
    if @player.sum_points > @dealer.sum_points
      puts "Player wins!!!"
    elsif @player.sum_points < @dealer.sum_points
      puts "Dealer wins!!"
    else 
      puts "It's a tie."
    end 
    exit
  end
  
  # def correct_score_for_aces
  #   self.cards_in_hand.select {|card| card.value == "A"}.count.times do 
  #     total -= 10 if total > 21  
  #   end
  # end 
  
  def play
    opening_deal
    choose_hit_or_stay(@player)
    dealer_hit_or_stay(@dealer)
    compare_scores 
  end
end 

game = Game.new
game.play
