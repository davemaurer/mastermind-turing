require 'minitest/autorun'
require 'minitest/pride'
require './lib/timer'

describe Timer do
  before do
    @timer = Timer.new
  end

  it 'has a start time' do
    assert @timer.start
  end

  it 'has a stop time' do
    assert @timer.stop
  end
end


