require "./spec_helper"

describe AdventOfCode do
  input = "35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"
data = input.lines.map(&.to_i)
  describe "9.1" do
    describe "XMAS" do
      it "passes example" do
        AdventOfCode::XMAS(Int32).new(data).first_invalid(5)[1].should eq 127
      end
    end
  end

  describe "9.2" do
    describe "XMAS" do
      it "passes example" do
        AdventOfCode::XMAS(Int32).new(data).encryption_weakness(14, 127).should eq 62
      end
    end
  end
end
