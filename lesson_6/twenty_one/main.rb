require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('main.yml')

DECK_VALUES = {
  '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8,
  '9' => 9, '10' => 10, 'Jack' => 10,
  'Queen' => 10, 'King' => 10, 'Ace' => [1, 11]
}

GOAL = 31
MIN_DEALER_HIT = 27

def prompt(message)
  puts "=> #{message}"
end

def busted?(cards)
  total(cards) > GOAL
end

def total(cards)
  card_hashes = cards.map { |card| card["pip"] }
  sum = 0
  card_hashes.each do |hash|
    sum += if hash.keys.join == 'Ace'
             11
           elsif hash.keys.join.to_i == 0
             hash.values.join.to_s.to_i
           else
             hash.values.join.to_s.to_i
           end
  end

  card_hashes.select { |hash| hash.keys.join == "Ace" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# +------- 1 (INITIALIZE DECK) -------+
def initialize_deck
  suit_hash = {}
  suits = [:hearts, :diamonds, :clubs, :spades]
  suits.each { |suit| suit_hash[suit] = DECK_VALUES.to_a.to_h }
  suit_hash
end

# +--------- 2 (DEAL CARDS) ---------+
def deal_card(deck)
  card = assign_card(deck)
  remove_assigned_card(card, deck)
  card
end

def assign_card(deck)
  suit = which_suit?(deck)
  card = deck[suit].to_a.sample
  { "pip" => { card[0] => card[1] }, "suit" => suit } # pip is the symbol
end

def which_suit?(deck)
  suits = []
  deck.each_key { |suit| suits << suit unless deck[suit].empty? }
  suits.sample
end

def remove_assigned_card(card, deck)
  pip_key = card["pip"].keys.join
  suit = card["suit"]
end

def deal_initial_two_cards(deck)
  card1 = deal_card(deck)
  card2 = deal_card(deck)
  return card1, card2
end

# +---------- DISPLAY CARDS ----------+
def show_welcome_and_rules?
  prompt "Welcome to Twenty-one!"
  prompt "Would you like some reminders on how to play Twenty-one?"
  prompt "(y for YES, any key for NO)"
  choice = gets.chomp.downcase
  welcome_message if choice == 'y'
end

def welcome_message
  prompt(MESSAGES['welcome'])
  puts " "
  prompt(MESSAGES['rules'])
  prompt("Let's play!")
  sleep 6
  system("clear")
end

def display_player_cards(cards)
  names = []
  cards.each { |e| names << "#{e['pip'].keys.join} of #{e['suit']}" }
  prompt "You have #{join(names)}"
end

def display_dealer_cards(cards)
  names = []
  cards.each { |e| names << "#{e['pip'].keys.join} of #{e['suit']}" }
  prompt "Dealer has #{names.sample} and another card"
end

def join(arr, delimiter = ', ', word = 'and')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

# +--- 3 PLAYER TURN (HIT OR STAY) ---+
def player_hit_or_stay?(deck, cards)
  answer = nil
  loop do
    prompt "hit or stay?"
    answer = gets.chomp.downcase.strip
    cards << deal_card(deck) if answer == 'hit'
    break if answer == 'stay' || busted?(cards)
    display_player_cards(cards)
  end
  if busted?(cards)
    'busted'
  else
    prompt "You stayed. Let's see what the dealer has"
    'stay'
  end
end

# +--------- 4 PLAYER BUSTS? ---------+
def player_busted?(string)
  string == 'busted'
end

# +---------- 5 DEALER TURN ----------+

def dealer_hit_or_stay?(deck, cards)
  until total(cards) >= MIN_DEALER_HIT
    cards << deal_card(deck)
  end
  busted?(cards) ? 'busted' : 'stay'
end

# +--------- 6 DEALER BUSTS? ---------+
def dealer_busted?(string)
  string == 'busted'
end

# +- 7 COMPARE CARDS/DECLARE WINNER --+
def declare_winner(player, dealer)
  winner = total(player) > total(dealer) ? "Player" : "Dealer"
  pl_total = total(player)
  de_total = total(dealer)
  prompt("Player had #{pl_total}, dealer had #{de_total}. #{winner} wins this round!")
	sleep 2
  winner
end

# +------------ MAIN GAME ------------+
times_played = 0
round_winners = {'Player' => 0, 'Dealer' => 0}

loop do
  show_welcome_and_rules? if times_played == 0
	
  deck = initialize_deck
  player_cards = deal_initial_two_cards(deck)
  dealer_cards = deal_initial_two_cards(deck)

  display_player_cards(player_cards)
  display_dealer_cards(dealer_cards)
  player_outcome = player_hit_or_stay?(deck, player_cards)
  dealer_outcome = dealer_hit_or_stay?(deck, dealer_cards)

  current_round_winner = if player_busted?(player_outcome)
            prompt "You busted. Dealer wins this round!"
						sleep 2
            'Dealer'
           elsif dealer_busted?(dealer_outcome)
             prompt "Dealer busted. You win this round!"
						 sleep 2
             'Player'
           else
             declare_winner(player_cards, dealer_cards)
           end
  round_winners[current_round_winner] += 1

  if round_winners['Player'] == 5
    prompt "You've won five rounds!"
    break
  elsif round_winners['Dealer'] == 5
    prompt "Dealer won five rounds!"
    break
  end

  times_played += 1
  system "clear"
	
	prompt "Player has won #{round_winners['Player']}"
	prompt "Dealer has won #{round_winners['Dealer']}"
	sleep 1
	system "clear"
end

# break unless play_again?
