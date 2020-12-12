require "./spec_helper"

describe AdventOfCode do
  input = "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"
  describe "11.1" do
    describe "Ferry#seating_one" do
      it "passes example" do
        ferry = AdventOfCode::Ferry.new(input)
        ferry.seating_one(1).seats_filled.should eq 71
        ferry.seating_one(1).seats_filled.should eq 20
        ferry.seating_one.seats_filled.should eq 37
      end
    end
  end

  describe "11.2" do
    describe "Ferry#seating_two" do
      it "passes example" do
        ferry = AdventOfCode::Ferry.new(input)
        ferry.seating_two(1).seats_filled.should eq 71
        ferry.seating_two(1).seats_filled.should eq 7
        ferry.seating_two(1).seats_filled.should eq 53
        ferry.seating_two(1).seats_filled.should eq 18
        ferry.seating_two.seats_filled.should eq 26
      end
    end
  end
end
