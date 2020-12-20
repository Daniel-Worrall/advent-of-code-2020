module AdventOfCode
  class Shuttle
    @timestamp : Int32
    @busses : Array(Int32?)

    def initialize(input : String)
      timestamp, busses = input.split('\n')
      @timestamp = timestamp.to_i
      @busses = busses
        .split(',')
        .map { |bus| bus.to_i? }
    end

    def earliest_bus : Int32
      minimum = @busses.reject(Nil).map do |bus|
        time = bus - @timestamp % bus
        {bus, time}
      end.min_by { |(_, v)| v }
      minimum[0] * minimum[1]
    end

    def earliest_sequence
      arr = @busses
        .each
        .with_index
        .reject({Nil, Int32})
        .to_a
        .map { |t| {t[0].not_nil!.to_i64, -t[1].to_i64} }
      chinese_remainder(arr)
    end

    private def chinese_remainder(arr : Array(Tuple(Int64,Int64))) : Int64
      max = arr.product(&.[0])
      arr.sum do |(m, r)|
        max // m * (r.abs < (m + r) ? r : (m + r)) * inverse(max // m, m)
      end % max
    end

    private def inverse(a : Int64, n : Int64)
      t, newt, r, newr = 0_i64, 1_i64, n, a

      until newr == 0
        q = (r // newr).to_i64
        t, newt = newt, t - newt * q
        r, newr = newr, r - newr * q
      end
      t % n
    end
  end

  extend self

  def run_13_1
    Shuttle.new(get_file).earliest_bus
  end

  def run_13_2
    Shuttle.new(get_file).earliest_sequence
  end
end
