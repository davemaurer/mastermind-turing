require 'minitest/autorun'
require 'minitest/pride'
require './lib/mastermind'

describe Mastermind do
  before do
    @mm = Mastermind.new
  end

  it 'exists' do
    assert Mastermind
  end

  it 'starts with a secret winning combination' do
    assert @mm.secret
    assert_equal 4, @mm.secret.length
  end

  it 'creates a random winning combination each time' do
    base = Mastermind.new
    mm1, mm2, mm3, mm4, mm5, mm6, mm7, mm8, mm9, mm10 = Mastermind.new
    minds = [mm1, mm2, mm3, mm4, mm5, mm6, mm7, mm8, mm9, mm10]
    same = minds.map { |m| return false unless m.secret == base.secret }
    refute same
  end

  it 'has a greet_player method' do
    assert_includes @mm.greet_player, 'Hello!'
  end

  it 'reads a player response to a prompt' do
    with_stdin do |player|
      player.puts 'y'
      assert_equal 'y', @mm.read_player_input
    end
  end

  it 'wins' do
    skip
    result = @mm.execute('BBGB')
    assert result.message.downcase.include?('win')
  end

  private
  def with_stdin
    stdin = $stdin
    $stdin, write = IO.pipe
    yield write
  ensure
    write.close
    $stdin = stdin
  end
end
