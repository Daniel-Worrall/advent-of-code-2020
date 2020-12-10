module AdventOfCode
  extend self

  def expense_report(num, arr : Array(T)) : T forall T
    arr.each_combination(num)
      .find { |x| x.sum == 2020 }
      .not_nil!
      .product
  end

  def run_1_1
    expenses = get_file.split("\n").map(&.to_i)
    expense_report(2, expenses)
  end

  def run_1_2
    expenses = get_file.split("\n").map(&.to_i)
    AdventOfCode.expense_report(3, expenses)
  end
end
