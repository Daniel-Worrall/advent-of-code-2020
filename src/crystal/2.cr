module AdventOfCode
  extend self

  def valid_password(password : String) : Bool
    numbers, char, pass = password.split
    from, to = numbers.split("-")
    char = char[0]
    count = pass.count(char)
    count >= from.to_i && count <= to.to_i
  end

  def valid_password_2(password : String) : Bool
    numbers, char, pass = password.split
    numbers = numbers.split("-").map(&.to_i)
    char = char[0]
    numbers.count { |num| pass[num - 1] == char } == 1
  end

  def run_2_1
    File.read("#{__DIR__}/input/2.txt").split("\n").count { |pass| valid_password(pass) }
  end

  def run_2_2
    File.read("#{__DIR__}/input/2.txt").split("\n").count { |pass| valid_password_2(pass) }
  end
end
