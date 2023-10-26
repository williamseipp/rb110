WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

wins = []
current_player = 'human'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(numbers, divider = ', ', word = 'or')
  choices = ""

  numbers.each do |num|
    choices << if num == numbers[-2] && numbers.size == 2
                 "#{num} #{word}"
               elsif num == numbers[-2] && numbers.size >= 3
                 "#{num}#{divider}#{word}"
               elsif num == numbers[-1]
                 " #{num}"
               else
                 "#{num}#{divider}"
               end
  end
  choices
end

def threatening_square(brd)
  square = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      square = line.intersection(empty_squares(brd)).first
    end
  end
  square
end

def winning_square(brd)
  square = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      square = line.intersection(empty_squares(brd)).first
    end
  end
  square
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    # if brd.values_at(*line).count(PLAYER_MARKER) == 3
    if brd.values_at(*line).all? { |square| square == PLAYER_MARKER }
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def player_choice(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  square
end

def computer_choice(brd)
  if !winning_square(brd).nil?
    winning_square(brd)
  elsif !threatening_square(brd).nil?
    threatening_square(brd)
  elsif empty_squares(brd).include?(5)
    5
  else
    empty_squares(brd).sample
  end
end

def place_piece!(board, player)
  if player == 'human'
    square = player_choice(board)
    board[square] = PLAYER_MARKER
  else
    square = computer_choice(board)
    board[square] = COMPUTER_MARKER
  end
end

def alternate_player(current_player)
  if current_player == 'human'
    'computer'
  else
    'human'
  end
end

loop do
  board = initialize_board

  prompt "Do you want to go first? (y or n)"
  answer = gets.chomp
  if answer.downcase.start_with?('n')
    prompt "Let's let the computer decide then"
    current_player = ['human', 'computer'].sample
    puts "Computer insists you go first" if current_player == 'human'
    sleep(1.5)
  else
    current_player = 'human'
  end

  loop do
    display_board(board)

    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    wins << detect_winner(board)
  else
    prompt "It's a tie!"
  end

  if wins.count("Player") == 5 || wins.count("Computer") == 5
    prompt "#{detect_winner(board)} won 5 games!"
    break
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
