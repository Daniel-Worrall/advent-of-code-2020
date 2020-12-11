module AdventOfCode
  extend self

  def jolt_differences(input : String)
    hash = Hash(Int32, Int32).new(0)
    adapters = input.lines.map(&.to_i).sort
    adapters.each_cons_pair { |a, b| hash[b - a] += 1 }
    hash[adapters.first] += 1 # Difference between 0 and lowest
    hash[1] * (hash[3] + 1)   # built in adapter always has +3
  end

  # There are only differences of 1 or 3.
  # There are no permutations when the difference is 3.
  # The numbers of permutations depends on the size of the group of 1s.
  # We take the number of all possible skips (2^(n-2)) and subtract the impossible
  # the n-2 is because the first and last element can be ignored for this method
  #
  # We don't actually do this yet, and brute force it instead because I couldn't figure out
  # a formula for number of impossible sequences.
  def jolt_permutations(input : String)
    input.lines.map(&.to_i).push(0).sort # Don't forget the 0!
      .slice_when { |i, j| i + 1 != j }
      .reject(&.size.<=(2)) # 1 or 2 elements only have 1 possibility
      .map(&->jolt_brute_force(Array(Int32)))
      .map(&.to_i64)
      .product
  end

  private def jolt_brute_force(list)
    (list.size + 1).times.reduce do |acc, i|
      acc + list.each_combination(i).count do |arr|
        next false unless arr.first == list.first && arr.last == list.last
        # arr.each.cons_pair.any? { |a, b| b - a > 3 } Fixed on master
        arr.each.cons(2, reuse: true).all? { |(a, b)| b - a <= 3 }
      end
    end
  end

  def run_10_1
    jolt_differences(get_file)
  end

  def run_10_2
    jolt_permutations(get_file)
  end
end
