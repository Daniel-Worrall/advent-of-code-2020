require "./spec_helper"

describe AdventOfCode do
  describe "2.1" do
    describe "valid_password" do
      it "passes example" do
        AdventOfCode.valid_password("1-3 a: abcde").should eq true
        AdventOfCode.valid_password("1-3 b: cdefg").should eq false
        AdventOfCode.valid_password("2-9 c: ccccccccc").should eq true
      end
    end
  end

  describe "2.2" do
    describe "valid_password" do
      it "passes example" do
        AdventOfCode.valid_password_2("1-3 a: abcde").should eq true
        AdventOfCode.valid_password_2("1-3 b: cdefg").should eq false
        AdventOfCode.valid_password_2("2-9 c: ccccccccc").should eq false
      end
    end
  end
end
