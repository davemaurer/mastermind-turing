class Mastermind
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
end
