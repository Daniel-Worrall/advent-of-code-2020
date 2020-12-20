require "./spec_helper"

describe AdventOfCode do
  input = "939
7,13,x,x,59,x,31,19"
  describe "13.1" do
    describe "Shuttle#earliest_bus" do
      it "passes example" do
        AdventOfCode::Shuttle.new(input).earliest_bus.should eq 295
      end
    end
  end

  describe "13.2" do
    describe "Shuttle" do
      it "passes example" do
        AdventOfCode::Shuttle.new(input).earliest_sequence.should eq 1068781
        AdventOfCode::Shuttle.new("0\n17,x,13,19").earliest_sequence.should eq 3417
        AdventOfCode::Shuttle.new("0\n67,7,59,61").earliest_sequence.should eq 754018
        AdventOfCode::Shuttle.new("0\n67,x,7,59,61").earliest_sequence.should eq 779210
        AdventOfCode::Shuttle.new("0\n67,7,x,59,61").earliest_sequence.should eq 1261476
        AdventOfCode::Shuttle.new("0\n1789,37,47,1889").earliest_sequence.should eq 1202161486
      end
    end
  end
end
