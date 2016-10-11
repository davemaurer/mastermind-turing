require_relative 'messages'

class Mastermind
  include Messages
  attr_reader   :secret, :valid_letters
  attr_accessor :started

  def initialize
    @secret        = create_secret
    @started       = false
    @valid_letters = ['R', 'B', 'G', 'Y']
  end

  def execute

  end

  def create_secret
    key    = 'BRGY'
    secret = ''
    4.times { secret << key[rand(0..3)] }
    secret
  end

  def read_player_input
    gets.chomp.upcase
  end

  def react_to_input(input)
    guess        = input.chars
    play         = lambda { play_game }
    quit         = lambda { quit_game }
    cheat        = lambda { cheat_to_win }
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
    guess.length == 4 && guess.all? { |letter| valid_letters.include?(letter) }
  end

  def evaluate_guess(guess)

    correct_colors    = 0
    correct_positions = 0
    key               = secret.chars
    colors            = guess.uniq
    guess.each_with_index do |letter, index|
      correct_positions += 1 if letter == key[index]
    end
    colors.each do |color|
      correct_colors += 1 if key.include?(color)
    end
    give_guess_feedback(correct_colors, correct_positions)
    react_to_input(read_player_input)
  end

  def ask_to_play
    greet_player
    react_to_input(read_player_input)
  end

  def play_game
    if @started
      announce_invalid_input(@started)
    else
      @started = true
      ask_for_guess
    end
    react_to_input(read_player_input)
  end

  def quit_game
    @started = false
    say_goodbye
  end

  def give_instructions
    if !@started
      print_instructions
    else
      announce_invalid_input(@started)
    end
      react_to_input(read_player_input)
  end

  def cheat_to_win
    @started = false
    print_answer(secret)
    @secret = create_secret
    ask_to_play_again
    react_to_input(read_player_input)
  end

  def ask_for_clarification
    announce_invalid_input(started)
    react_to_input(read_player_input)
  end
end

mm = Mastermind.new
mm.ask_to_play
