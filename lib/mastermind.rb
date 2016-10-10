require_relative 'messages'

class Mastermind
  include Messages
  attr_reader :secret
  attr_accessor :input

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

  def start_game
    greet_player
    react_to_input(read_player_input, 'instructions_only')
  end
end

# mm = Mastermind.new
# mm.start_game
