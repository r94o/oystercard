class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Max balance is £#{MAXIMUM_BALANCE}" if will_exceed_max_balance?(amount)
    @balance += amount
  end

  def touch_in
    fail "You have already touched in" if in_journey?
    fail "You need to top up" if @balance == 0
    @in_journey = true
  end

  def touch_out
    fail "You have not touched in" unless in_journey?
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def will_exceed_max_balance?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

end