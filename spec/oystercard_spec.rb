require 'oystercard'

describe Oystercard do
  describe "#balance" do
    it "starts with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
  
  describe "#top_up" do
    it "adds 50 to the balance and returns the new balance" do  
      expect(subject.top_up(50)).to eq(50)
    end
  end
end

