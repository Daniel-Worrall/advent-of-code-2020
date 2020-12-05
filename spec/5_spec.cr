require "./spec_helper"

describe AdventOfCode do
  describe "5.1" do
    describe "BoardingPass" do
      it "passes example" do
        pass = AdventOfCode::BoardingPass.new("BFFFBBFRRR")
        pass.row.should eq 70
        pass.column.should eq 7
        pass.seat_id.should eq 567
        pass = AdventOfCode::BoardingPass.new("FFFBBBFRRR")
        pass.row.should eq 14
        pass.column.should eq 7
        pass.seat_id.should eq 119
        pass = AdventOfCode::BoardingPass.new("BBFFBBFRLL")
        pass.row.should eq 102
        pass.column.should eq 4
        pass.seat_id.should eq 820
      end
    end
  end
end
