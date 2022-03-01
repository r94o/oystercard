class Oystercard

  attr_reader :balance, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Max balance is £#{MAXIMUM_BALANCE}" if will_exceed_max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "You have already touched in" if in_journey?
    fail "You need to top up" if @balance < MINIMUM_FARE
    log_start_journey(station)
  end

  def touch_out(station)
    fail "You have not touched in" unless in_journey?
    deduct(MINIMUM_FARE)
    log_end_journey(station)
  end

  def in_journey?
    !!@start_time
  end

  private

  def log_start_journey(station)
    @start_time = Time.now
    @this_journey = { @start_time => [station]}
  end

  def log_end_journey(station)
    @this_journey[@start_time] << station
    @start_time = nil
    save_journey
  end

  def save_journey
    @journey_history << @this_journey
  end

  def will_exceed_max_balance?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
