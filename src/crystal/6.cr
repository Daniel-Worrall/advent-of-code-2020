module AdventOfCode
  extend self

  def run_6_1
    get_file.split("\n\n").sum do |group|
      (group.chars.to_set - ['\n']).size
    end
  end

  def run_6_2
    get_file.split("\n\n").sum do |group|
      group.split('\n').map(&.chars.to_set).reduce { |acc, set| acc & set }.size
    end
  end
end
