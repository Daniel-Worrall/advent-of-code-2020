module AdventOfCode
  class TobogganMap
    @map : Array(Array(Bool))
    @x_size : Int32

    def initialize(input : String)
      @map = input.lines.map { |line| line.chars.map(&.==('#')) }
      @x_size = @map[0].size
    end

    def trees(x, y) : UInt64
      count = 0_u64
      current_x = current_y = 0
      while current_y < @map.size
        count += 1 if @map[current_y][current_x]
        current_x = (current_x + x) % @x_size
        current_y += y
      end
      count
    end

    def tree_product : UInt64
      [
        trees(1, 1),
        trees(3, 1),
        trees(5, 1),
        trees(7, 1),
        trees(1, 2),
      ].product
    end
  end

  extend self

  def run_3_1
    AdventOfCode::TobogganMap.new(File.read("#{__DIR__}/input/3.txt")).trees(3, 1)
  end

  def run_3_2
    AdventOfCode::TobogganMap.new(File.read("#{__DIR__}/input/3.txt")).tree_product
  end
end
