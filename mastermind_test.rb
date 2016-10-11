require 'minitest/autorun'
require 'minitest/pride'
require './lib/mastermind'

describe Mastermind do
  before do
    @mm = Mastermind.new
  end

  describe 'mastermind' do
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

    it "reads a player's response to a prompt" do
      with_stdin do |player|
        player.puts 'y'
        @result = assert_equal 'Y', @mm.read_player_input
      end
      assert @result
    end

    it 'properly reacts to player input' do
      assert_output(/Quitting the game/) { @mm.react_to_input('Q') }
    end

    it 'has a play_game method' do
      skip
      assert @mm.respond_to?(play_game)
    end
  end

  describe 'game prompts' do
    it 'greets a player' do
      assert_output(/Hello!/) { @mm.greet_player }
    end

    it 'plays a game' do
      assert_output(/I've made a secret key/) { @mm.ask_for_guess }
    end

    it 'quits a game' do
      assert_output(/Quitting the game/) { @mm.quit_game }
    end

    it 'gives instructions' do
      assert_output(/Once you hit/) { @mm.print_instructions }
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
