class Timer
  def initialize
    @start_time = nil
    @stop_time  = nil
  end

  def start
    @start_time = Time.now
  end

  def stop
    @end_time = Time.now
  end

  def time_taken
    @end_time - @start_time
  end
end
