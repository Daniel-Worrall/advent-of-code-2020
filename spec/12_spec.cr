require "./spec_helper"

describe AdventOfCode do
  input = "F10
N3
F7
R90
F11"
  describe "12.1" do
    describe "Navigation#navigate" do
      it "passes example" do
        AdventOfCode::Navigation.new(input).navigate.manhatten.should eq 25
      end
    end
  end

  describe "12.2" do
    describe "Navigation#navigate_waypoint" do
      it "passes example" do
        ship = AdventOfCode::Navigation.new(input)
        ship.navigate_waypoint(1).manhatten.should eq 110
        ship.navigate_waypoint(2).manhatten.should eq 208
        AdventOfCode::Navigation.new(input).navigate_waypoint.manhatten.should eq 286

      end
    end
  end
end
