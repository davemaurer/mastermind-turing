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
    gets.chomp
  end
end

mm = Mastermind.new
mm.greet_player
