module AdventOfCode
  class MemoryGame
    @steps = 0
    @visited = Hash(Int32, Int32).new(0)
    @input : Array(String)

    def initialize(input)
      @input = input.split(",")
    end

    def run_to(steps)
      raise "Less steps than starting" unless steps >= @input.size
      if @steps < @input.size
        @input.each do |step|
          @visited[step.to_i] = @steps += 1
        end
      end
      num = @visited.keys.last
      until @steps == steps
        difference = (lookup = @visited[num]) == 0 ? 0 : @steps - lookup
        @visited[num] = @steps
        @steps += 1
        num = difference
      end
      num
    end
  end

  extend self

  def run_15_1
    MemoryGame.new("2,0,1,9,5,19").run_to(2020)
  end

  def run_15_2
    MemoryGame.new("2,0,1,9,5,19").run_to(30000000)
  end
end
