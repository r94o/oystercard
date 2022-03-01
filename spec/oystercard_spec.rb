require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  MAXIMUM_BALANCE = Oystercard::MAXIMUM_BALANCE
  MINIMUM_FARE = Oystercard::MINIMUM_FARE
  
  describe "#balance" do
    it "starts with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#journey_history" do
    it "starts as an empty array" do
      expect(subject.journey_history).to be_empty
    end
  end

  context "starting balance is MINIMUM FARE" do
    before do
      subject.top_up(MINIMUM_FARE)
    end

    describe "#top_up" do
      it "can top up" do  
        expect(subject.balance).to eq(MINIMUM_FARE)
      end
      it "raises an error when the balance exceeds #{MAXIMUM_BALANCE}" do
        expect { subject.top_up(MAXIMUM_BALANCE) }.to raise_error("Max balance is £#{MAXIMUM_BALANCE}")
      end
    end

    describe "#touch_in" do
      it "can touch in" do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
      it "raises error if #touch_in twice without #touch_out" do
        subject.touch_in(entry_station)
        expect { subject.touch_in(entry_station) }.to raise_error("You have already touched in")
      end
    end

    describe "#touch_out" do
      it "can touch out" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).to_not be_in_journey
      end
      it "reduces balance by #{MINIMUM_FARE}" do
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-MINIMUM_FARE)
      end
      it "logs the journey" do
        allow(Time).to receive(:now).and_return(:start_time)
        subject.touch_in(entry_station)
        expect(subject.touch_out(exit_station)).to eq([{start_time: [entry_station, exit_station]}])
      end
    end
    
    describe "#in_journey?" do
      it "is in a journey once touched in" do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
      it "is not in a journey once touched out" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).to_not be_in_journey
      end
    end
  end

  context "balance is below #{MINIMUM_FARE}" do
    describe "#touch_in" do 
      it "raises error" do
        expect { subject.touch_in(entry_station) }.to raise_error("You need to top up")
      end
    end
  end

  describe "#touch_out" do
    it "raises error if #touch_out without #touch_in" do
      expect { subject.touch_out(exit_station) }.to raise_error("You have not touched in")
    end
  end

  describe "#in_journey?" do
    it "is initially not in a journey" do
      expect(subject).to_not be_in_journey
    end
  end
end