require 'oystercard'

describe Oystercard do
  MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
  describe "#balance" do
    it "starts with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
  
  describe "#top_up" do
    it "adds 50 to the balance and returns the new balance" do  
      expect(subject.top_up(50)).to eq(50)
    end
    it "raises an error when the balance exceeds #{MAXIMUM_BALANCE}" do
      subject.top_up(MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("Max balance is £#{MAXIMUM_BALANCE}")
    end
  end
end

