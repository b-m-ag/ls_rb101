INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals

# game prep logic
def ask_whos_first
  turn = ''
  system 'clear'
  puts "Welcome to Tic Tac Toe!"
  loop do
    prompt "Who goes first?"
    prompt "Enter 'p' if Player or 'c' if Computer."
    prompt "Enter 'r' if you would like the computer to choose."
    turn = gets.chomp.downcase
    break if turn == 'p' || turn == 'c' || turn == 'r'
    prompt "That's not a valid choice."
  end
  comp_choice = ['c', 'p']
  turn = comp_choice.sample if turn == 'r'
  turn
end

def ask_difficulty_level
  level = ''
  system 'clear'
  loop do
    prompt "What level of difficulty should the Computer play against you?"
    prompt "Enter '1' for easy."
    prompt "Enter '2' for medium."
    prompt "Enter '3' for hard."
    level = gets.chomp
    break if level == '1' || level == '2' || level == '3'
    prompt "That's not a valid choice."
  end
  level
end
# end of game prep logic

# game dispaly logic
def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize/
# rubocop:disable Metrics/MethodLength
# rubocop:disable Layout/LineLength
def display_board(brd, score, level)
  system 'clear'
  puts "Tic Tac Toe"
  puts "Difficulty level: #{level}"
  puts "Player is 'X' | Computer is 'O'"
  puts "Win five games to win the match!"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "  #{square_id(brd, 1)}  |  #{square_id(brd, 2)}  |  #{square_id(brd, 3)}"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "  #{square_id(brd, 4)}  |  #{square_id(brd, 5)}  |  #{square_id(brd, 6)}"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "  #{square_id(brd, 7)}  |  #{square_id(brd, 8)}  |  #{square_id(brd, 9)}"
  puts ""
  puts "Player: #{score[:player]} | Computer: #{score[:computer]}"
  puts ""
end
# rubocop:enable Metrics/AbcSize/
# rubocop:enable Metrics/MethodLength
# rubocop:enable Layout/LineLength

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def square_id(brd, num)
  if brd[num] == INITIAL_MARKER
    num
  else
    ' '
  end
end

def joinor(arr, separator= ', ', conjunction= 'or')
  return arr.last if arr.size == 1
  arr2 = arr - [arr.last]
  arr2.join(separator) + " #{conjunction} #{arr.last}"
end

def score_counter!(win, score)
  if win == 'Player'
    score[:player] += 1
  elsif win == 'Computer'
    score[:computer] += 1
  end
end

def display_game_result(won, brd)
  puts "#{detect_winner(brd)} won this game!" if won
  puts "Tie game! No score." if !won
end

def display_match_result(score)
  puts "Player won the match!" if score[:player] == 5
  puts "Computer won the match!" if score[:computer] == 5
end

def score_five?(score)
  if score[:player] == 5
    true
  elsif score[:computer] == 5
    true
  end
end
# end game display logic

# Computer selection strategy logic
def square_strategy?(mkr, mks, q, r)
  mks.count(mkr) == q && mks.count(INITIAL_MARKER) == r
end

def hard_difficulty!(brd)
  WINNING_LINES.each do |line|
    marks = brd.values_at(*line)
    if square_strategy?(COMPUTER_MARKER, marks, 2, 1) # winning square
      return brd[line[marks.index(INITIAL_MARKER)]] = COMPUTER_MARKER
    end
  end
  hard_defensive_square!(brd)
end

def hard_defensive_square!(brd)
  WINNING_LINES.each do |line|
    marks = brd.values_at(*line)
    if square_strategy?(PLAYER_MARKER, marks, 2, 1) # defensive square
      return brd[line[marks.index(INITIAL_MARKER)]] = COMPUTER_MARKER
    end
  end
  middle_square!(brd)
end

def middle_square!(brd)
  if brd[5] == INITIAL_MARKER
    return brd[5] = COMPUTER_MARKER
  end
  offensive_square!(brd)
end

def medium_difficulty!(brd)
  WINNING_LINES.each do |line|
    marks = brd.values_at(*line)
    if square_strategy?(COMPUTER_MARKER, marks, 2, 1) # winning square
      return brd[line[marks.index(INITIAL_MARKER)]] = COMPUTER_MARKER
    end
  end
  offensive_square!(brd)
end

def offensive_square!(brd)
  WINNING_LINES.each do |line|
    marks = brd.values_at(*line)
    if square_strategy?(COMPUTER_MARKER, marks, 1, 2)
      return brd[line[marks.index(INITIAL_MARKER)]] = COMPUTER_MARKER
    end
  end
  random_square!(brd)
end

def easy_difficulty!(brd)
  random_square!(brd)
end

def random_square!(brd)
  brd[empty_squares(brd).sample] = COMPUTER_MARKER
end

def computer_places_piece!(brd, level)
  if level == '1'
    easy_difficulty!(brd)
  elsif level == '2'
    medium_difficulty!(brd)
  elsif level == '3'
    hard_difficulty!(brd)
  end
end
# end of Computer selection strategy logic

def player_places_piece!(brd)
  square = ''
  if brd.values.count(INITIAL_MARKER) == 1
    return brd[empty_squares(brd).last] = PLAYER_MARKER
  end
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def place_piece!(brd, plyr, level)
  if plyr == 'p'
    player_places_piece!(brd)
  elsif plyr == 'c'
    computer_places_piece!(brd, level)
  end
end

# game play logic
def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def alternate_player(plyr)
  if plyr == 'p'
    plyr = 'c'
  elsif plyr == 'c'
    plyr = 'p'
  end
  plyr
end

def game_play!(brd, score, level, player)
  current_player = player
  loop do
    display_board(brd, score, level)
    place_piece!(brd, current_player, level)
    current_player = alternate_player(current_player)
    break if someone_won?(brd) || board_full?(brd)
  end
end
# end of game play logic

# game play
first_player = ask_whos_first
chosen_level = ask_difficulty_level

loop do
  match_score = { player: 0, computer: 0 }
  loop do
    board = initialize_board
    game_play!(board, match_score, chosen_level, first_player)
    display_board(board, match_score, chosen_level)
    display_game_result(someone_won?(board), board)
    prompt "Press 'Enter' to continue."
    gets.chomp
    score_counter!(detect_winner(board), match_score)
    display_board(board, match_score, chosen_level)
    display_match_result(match_score)
    break if score_five?(match_score)
  end
  prompt "Play again?(y or n)"
  answer = gets.chomp
  (first_player = ask_whos_first) if answer == 'y'
  (chosen_level = ask_difficulty_level) if answer == 'y'
  break unless answer.downcase.start_with?('y')
end

puts "Thanks for playing Tic Tac Toe!"
puts "Good-bye!"