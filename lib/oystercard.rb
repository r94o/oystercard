class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def wallet_empty?
    @balance == 0
  end

end