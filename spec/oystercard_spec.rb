require 'oystercard'

describe Oystercard do
  MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
  
  describe "#balance" do
    it "starts with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  context "starting balance is MAXIMUM_BALANCE" do

    before do
      subject.top_up(MAXIMUM_BALANCE)
    end

    describe "#top_up" do
      it "can top up" do  
        expect(subject.balance).to eq(MAXIMUM_BALANCE)
      end
      it "raises an error when the balance exceeds #{MAXIMUM_BALANCE}" do
        expect { subject.top_up(1) }.to raise_error("Max balance is £#{MAXIMUM_BALANCE}")
      end
    end

    describe "#touch_in" do
      it "can touch in" do
        subject.touch_in
        expect(subject).to be_in_journey
      end
      it "raises error if #touch_in twice without #touch_out" do
        subject.touch_in
        expect { subject.touch_in }.to raise_error("You have already touched in")
      end
    end

    describe "#touch_out" do
      it "can touch out" do
        subject.touch_in
        subject.touch_out
        expect(subject).to_not be_in_journey
      end
    end
  end

  context "balance is 0" do
    describe "#touch_in" do 
      it "raises error" do
        expect { subject.touch_in }.to raise_error("You need to top up")
      end
    end
  end

  describe "#touch_out" do
    it "raises error if #touch_out without #touch_in" do
      expect { subject.touch_out }.to raise_error("You have not touched in")
    end
  end

  describe "#in_journey?" do
  it "is initially not in a journey" do
    expect(subject).to_not be_in_journey
  end
end
end

