require "position"

describe Position do
  describe "#decrement_position" do
    it "decrements the position in a list, but never goes below 1" do
      pos = Position.new(1)
      pos.decrement_position
      pos.decrement_position
      expect(pos.position).to eq(1)
    end
  end
end
