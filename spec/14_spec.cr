require "./spec_helper"

describe AdventOfCode do
  describe "BitMasks" do
    describe "14.1" do
      it "passes example" do
        input = "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0"
        AdventOfCode::BitMasks.new(input).run.sum.should eq 165
      end
    end

    describe "14.2" do
      it "passes example" do
        input = "mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1"
        AdventOfCode::BitMasks.new(input).run_v2.sum.should eq 208
      end
    end
  end
end
