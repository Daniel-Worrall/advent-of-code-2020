require "./spec_helper"

describe AdventOfCode do
  input = "class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12"
  describe "Tickets" do
    describe "16.1" do
      it "passes example" do
        AdventOfCode::Tickets.new(input).error_rate.should eq 71
      end
    end
  end
end
