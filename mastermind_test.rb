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
    assert_output(/Hello!/) { @mm.greet_player }
  end

  it 'reads a player response to a prompt' do
    with_stdin do |player|
      player.puts 'y'
      assert_equal 'Y', @mm.read_player_input
    end
  end

  describe 'game prompts' do
    it 'starts a game' do
      thread = Thread.new do
        @mm.ask_to_play
        with_stdin do |player|
          player.puts 'p'
          assert_output(/I've made a secret key/) { @mm.ask_to_play }
        end
      end
      thread.kill
    end

    it 'quits a game' do
      thread = Thread.new do
        with_stdin do |player|
          player.puts 'p'
          input1 = @mm.read_player_input
          @mm.react_to_input(input1)
        end
        with_stdin do |player|
          player.puts 'q'
          input2 = @mm.read_player_input
          @result = assert_output(/Quitting the game. Come back soon!!!/) { @mm.react_to_input(input2) }
        end
      end
      thread.kill
      assert @result
    end
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
