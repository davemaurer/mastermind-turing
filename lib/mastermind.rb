require_relative 'messages'
require_relative 'timer'

class Mastermind
  include Messages
  attr_reader   :secret, :valid_letters
  attr_accessor :started, :timer, :guess_counter

  def initialize
    @secret        = create_secret
    @started       = false
    @valid_letters = ['R', 'B', 'G', 'Y']
    @timer         = Timer.new
    @guess_counter = 0
  end

  def create_secret
    key    = 'BRGY'
    secret = ''
    4.times { secret << key[rand(3)] }
    secret
  end

  def read_player_input
    gets.chomp.upcase
  end

  def react_to_input(input)
    guess        = input.chars
    play         = lambda { play_game }
    quit         = lambda { quit_game }
    cheat        = lambda { try_to_cheat }
    instructions = lambda { give_instructions }
    responses    = { 'P' => play, 'Q' => quit, 'C' => cheat, 'I' => instructions }
    if responses.include?(input)
      responses[input].call
    elsif is_a_guess?(guess) && @started
      evaluate_guess(guess)
    else
      ask_for_clarification
    end
  end

  def is_a_guess?(guess)
    (guess.length == @secret.length) && valid_letters?(guess)
  end

  def valid_letters?(guess)
    guess.all? { |letter| valid_letters.include?(letter) }
  end

  def evaluate_guess(guess)
    key            = @secret.chars
    color_count    = count_correct_colors(guess, key)
    position_count = count_correct_positions(guess, key)
    @guess_counter += 1
    return declare_winner(guess) if guess == key
    give_guess_feedback(color_count, position_count)
    react_to_input(read_player_input)
  end

  def count_correct_colors(guess, key)
    correct_colors = 0
    guess.uniq.each { |color| correct_colors += 1 if key.include?(color) }
    correct_colors
  end

  def count_correct_positions(guess, key)
    correct_positions = 0
    guess.each_with_index { |letter, index| correct_positions += 1 if letter == key[index] }
    correct_positions
  end

  def declare_winner(guess)
    @timer.stop
    time = @timer.time_taken
    formatted_guess = guess.join
    print_player_wins(formatted_guess, time, @guess_counter)
    reset
  end

  def reset
    @started = false
    @secret = create_secret
    @guess_counter = 0
    ask_to_play_again
    react_to_input(read_player_input)
  end

  def ask_to_play
    greet_player
    react_to_input(read_player_input)
  end

  def play_game
    @started ? announce_invalid_input(@started) : start_game
    react_to_input(read_player_input)
  end

  def start_game
    @started = true
    @timer.start
    ask_for_guess
  end

  def quit_game
    @started = false
    say_goodbye
  end

  def give_instructions
    !@started ? print_instructions : announce_invalid_input(@started)
    react_to_input(read_player_input)
  end

  def try_to_cheat
    @started ? win_by_cheating : print_cant_cheat_yet
    react_to_input(read_player_input)
  end

  def win_by_cheating
    @started = false
    print_answer(@secret)
    @secret = create_secret
    ask_to_play_again
  end

  def ask_for_clarification
    announce_invalid_input(started)
    react_to_input(read_player_input)
  end
end

if __FILE__ == $0
  mm = Mastermind.new
  mm.ask_to_play
end
