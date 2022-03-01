class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Max balance is £#{MAXIMUM_BALANCE}" if will_exceed_max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "You have already touched in" if in_journey?
    fail "You need to top up" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    fail "You have not touched in" unless in_journey?
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station
  end

  private

  def will_exceed_max_balance?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end