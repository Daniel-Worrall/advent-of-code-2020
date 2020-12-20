require "./spec_helper"

describe AdventOfCode do
  describe "MemoryGame" do
    describe "15.1" do
      it "passes example" do
        AdventOfCode::MemoryGame.new("0,3,6").run_to(3).should eq 6
        AdventOfCode::MemoryGame.new("0,3,6").run_to(4).should eq 0
        AdventOfCode::MemoryGame.new("0,3,6").run_to(5).should eq 3
        AdventOfCode::MemoryGame.new("0,3,6").run_to(6).should eq 3
        AdventOfCode::MemoryGame.new("0,3,6").run_to(7).should eq 1
        AdventOfCode::MemoryGame.new("0,3,6").run_to(8).should eq 0
        AdventOfCode::MemoryGame.new("0,3,6").run_to(10).should eq 0
        AdventOfCode::MemoryGame.new("0,3,6").run_to(2020).should eq 436
        AdventOfCode::MemoryGame.new("1,3,2").run_to(2020).should eq 1
        AdventOfCode::MemoryGame.new("2,1,3").run_to(2020).should eq 10
        AdventOfCode::MemoryGame.new("1,2,3").run_to(2020).should eq 27
        AdventOfCode::MemoryGame.new("2,3,1").run_to(2020).should eq 78
        AdventOfCode::MemoryGame.new("3,2,1").run_to(2020).should eq 438
        AdventOfCode::MemoryGame.new("3,1,2").run_to(2020).should eq 1836
      end
    end

    describe "15.2" do
      it "passes example" do
        AdventOfCode::MemoryGame.new("0,3,6").run_to(30000000).should eq 175594
        AdventOfCode::MemoryGame.new("1,3,2").run_to(30000000).should eq 258
        AdventOfCode::MemoryGame.new("2,1,3").run_to(30000000).should eq 3544142
        AdventOfCode::MemoryGame.new("1,2,3").run_to(30000000).should eq 261214
        AdventOfCode::MemoryGame.new("2,3,1").run_to(30000000).should eq 6895259
        AdventOfCode::MemoryGame.new("3,2,1").run_to(30000000).should eq 18
        AdventOfCode::MemoryGame.new("3,1,2").run_to(30000000).should eq 362
      end
    end
  end
end
