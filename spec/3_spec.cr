require "./spec_helper"

describe AdventOfCode do
  describe "3" do
    input = "..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"
    describe "3.1" do
      describe "TobogganMap" do
        it "passes example" do
          AdventOfCode::TobogganMap.new(input).trees(3, 1).should eq 7
        end
      end
    end

    describe "3.2" do
      describe "TobogganMap" do
        it "passes example" do
          map = AdventOfCode::TobogganMap.new(input)
          map.trees(1, 1).should eq 2
          map.trees(3, 1).should eq 7
          map.trees(5, 1).should eq 3
          map.trees(7, 1).should eq 4
          map.trees(1, 2).should eq 2
          map.tree_product.should eq 336
        end
      end
    end
  end
end
