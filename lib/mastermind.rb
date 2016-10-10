require_relative 'messages'

class Mastermind
  include Messages
  attr_reader :secret

  def initialize
    @secret = create_secret
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
    play = lambda { play_game }
    quit = lambda { quit_game }
    responses = { 'P' => play, 'Q' => quit }
    responses[input].call
  end

  def ask_to_play
    greet_player
    react_to_input(read_player_input)
  end

  def play_game
    ask_for_guess
    react_to_input(read_player_input)
  end

  def quit_game
    say_goodbye
  end
end

# mm = Mastermind.new
# mm.ask_to_play
