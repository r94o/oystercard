class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Max balance is £#{MAXIMUM_BALANCE}" if will_exceed_max_balance?(amount)
    @balance += amount
  end

  private

  def will_exceed_max_balance?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

end