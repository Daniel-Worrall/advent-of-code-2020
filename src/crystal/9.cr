module AdventOfCode
  class XMAS(T)
    def initialize(@data : Array(T))
    end

    def first_invalid(preamble = 25)
      # Turn into a hash to keep track of original indices
      to_check = @data.each_with_index.skip(preamble).to_h { |e, i| {i, e} }

      # Use exclusive since we want to start 2 under the last index
      (0...@data.size).each do |base|
        checking = to_check.select((base..(base + preamble)).to_a)

        @data[base...base + preamble].each_combination(2, reuse = true) do |x|
          checking.select { |k, v| v == x.sum }.each do |k, v|
            checking.delete(k)
            to_check.delete(k)
          end
        end

        return {base, @data[base]} if checking.has_key?(base)
      end
      {0, T.zero}
    end

    def encryption_weakness(index, invalid_number : T)
      raise "Invalid" unless @data[index] == invalid_number

      @data.each_index do |index|
        sum = 0
        range = @data[index..].take_while do |value|
          sum += value
          sum < invalid_number
        end
        return range.minmax.sum if sum == invalid_number
      end
    end
  end

  extend self

  def run_9_1
    XMAS(Int64).new(File.read("#{__DIR__}/input/9.txt").lines.map(&.to_i64)).first_invalid
  end

  def run_9_2
    xmas = XMAS(Int64).new(File.read("#{__DIR__}/input/9.txt").lines.map(&.to_i64))
    xmas.encryption_weakness(
      504, 14144619 # *xmas.first_invalid
    )
  end
end
