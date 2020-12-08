require "./spec_helper"

describe AdventOfCode do
  input = "nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"
  describe "8.1" do
    describe "Console" do
      it "passes example" do
        AdventOfCode::Console.new(input).run.acc.should eq 5
      end
    end
  end

  describe "8.2" do
    describe "Console" do
      it "passes example" do
        AdventOfCode::Console.new(input).uncorrupt_run.acc.should eq 8
      end
    end
  end
end
