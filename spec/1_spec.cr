require "./spec_helper"

describe AdventOfCode do
  describe "1.1" do
    describe "expense_report" do
      it "passes example" do
        AdventOfCode.expense_report(2, [1721,979,366,299,675,1456]).should eq 514579
      end
    end
  end

  describe "1.2" do
    describe "expense_report" do
      it "passes example" do
        AdventOfCode.expense_report(3, [1721,979,366,299,675,1456]).should eq 241861950
      end
    end
  end
end
