require "./spec_helper"

describe AdventOfCode do
  input = "16
10
15
5
1
11
7
19
6
12
4"
  input2 = "28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3"
  describe "10.1" do
    describe "jolt_differences" do
      it "passes example" do
        AdventOfCode.jolt_differences(input).should eq 35
        AdventOfCode.jolt_differences(input2).should eq 220
      end
    end
  end

  describe "10.2" do
    describe "XMAS" do
      it "passes example" do
        AdventOfCode.jolt_permutations(input).should eq 8
        AdventOfCode.jolt_permutations(input2).should eq 19208
      end
    end
  end
end
