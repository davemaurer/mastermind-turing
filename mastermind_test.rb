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

  it 'starts with a winning combination' do
    assert @mm.secret
    assert_equal 4, @mm.secret.length
  end

  it 'wins' do
    skip
    result = @mm.execute("BBGB")
    assert result.message.downcase.include?("win")
  end
end
