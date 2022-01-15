require 'yaml'
MESSAGES = YAML.load_file('text.yml')

# --- Constant Def. (Start) --- #
NEW_LINE = "\n"
VALID_CHOICES = %w(r rock p paper sc scissors l lizard sp spock)

VALID_CPU_CHOICES = %w(rock paper scissors lizard spock)
RULES = {
  'rock': ['scissors', 'lizard'],
  'paper': ['rock', 'spock'],
  'scissors': ['paper', 'lizard'],
  'spock': ['scissors', 'rock'],
  'lizard': ['spock', 'paper']
}
WINNING_SCORE = 3
VALID_YES = ['y', 'yes']
VALID_NO = ['n', 'no']
# --- Constant Def. (End) --- #

# --- Method Def. (Start) --- #
def prompt(message)
	Kernel.puts("=> #{message}")
end

def clear_screen
	system('clear')
end

def welcome_screen
	clear_screen
	prompt(MESSAGES['welcome'])
	prompt(MESSAGES['game_rules'])
end

def abrreviation_expand(inp)
	case inp
	when 'r'
		inp = 'rock'
	when 'p'
		inp = 'paper'
	when 'sc'
		inp = 'scissors'
	when 'l'
		inp = 'lizard'
	when 'sp'
		inp = 'spock'
	end
	inp
end

def to_extend?(choice)
	if choice.length < 3
		abrreviation_expand(choice)
	else
		choice
	end
end

def approve_user_choice
	input = ''
	loop do
		prompt(MESSAGES['request_user_choice'])
		input = gets.chomp.downcase.strip
		if VALID_CHOICES.include?(input)
			input = to_extend?(input)
			break
		else
			prompt(MESSAGES['user_invalid_choice'])
		end
	end
	input
end

def get_cpu_choice
	VALID_CPU_CHOICES.sample
end

def print_game_num(total_g)
	prompt("Game ##{total_g}")
end

def print_scores(scores)
	prompt("Player score: #{scores[:player]}.")
	prompt("Computer score: #{scores[:computer]}")
end

def referee?(first, second)
	RULES[first].include?(second)
end

def winner(player, cpu)
	if referee?(player, cpu)
		'player'
	elsif referee?(cpu, player)
		'computer'
	else
		'tie'
	end
end

def update_scores(scores, winner)
  scores[winner.to_sym] += 1
end

def display_results(player, cpu, winner)
  prompt("You chose: #{player}. Computer chose: #{cpu}.")
  case winner
  when 'player' then prompt('You won!')
  when 'computer' then prompt('Computer won!')
  when 'tie' then prompt("It's a tie!")
  end
end

def next_game(games)
  games[0] += 1
end

def game_won?(scores)
  scores[:player] == WINNING_SCORE || scores[:computer] == WINNING_SCORE
end

def print_game_winner(scores)
  if scores[:player] == WINNING_SCORE
    prompt(MESSAGES['player_wins'])
  else
    prompt(MESSAGES['cpu_wins'])
  end
end

def play_again?
  loop do
    prompt("Do you want to play again? (Y/N)")
    answer = gets.chomp.downcase
    case answer
    when 'y', 'yes' then break true
    when 'n', 'no' then break false
    else puts "I don't understand. Answer yes or no (y or n work too)"
    end
  end
end
# --- Method Def. (End) --- #

# --- GAME STARTS --- #

welcome_screen

loop do # Initialize game count and score variables
	scores = { player: 0, computer: 0, tie: 0 }
	games = [1]

	loop do # Actual game until WINNING_SCORE
		print_game_num(games[0])

		user_move = approve_user_choice
		cpu_move = get_cpu_choice

		winner = winner(user_move, cpu_move)
		display_results(user_move, cpu_move, winner)

		update_scores(scores, winner)
		sleep 2

		break if game_won?(scores)

		clear_screen
		print_scores(scores)
		next_game(games)
		NEW_LINE
	end

	print_game_winner(scores)

	break unless play_again?
	clear_screen
end

clear_screen
prompt(MESSAGES['goodbye'])
