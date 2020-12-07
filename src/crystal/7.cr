module AdventOfCode
  class Haversack
    alias Contains = Hash(String, Int32)
    @rule_hash = Hash(String, Contains).new do |h, k|
      h[k] = Contains.new
    end
    @contained_by = Hash(String, Set(String)).new do |h, k|
      h[k] = Set(String).new
    end

    def initialize(rules : String)
      rules.each_line do |rule|
        container, containing = rule.split(" bags contain ")
        next if containing == "no other bags."
        containing.split(", ").each do |contents|
          if bag = contents.match(/(\d+) (.+) bag/)
            @rule_hash[container][bag[2]] = bag[1].to_i
            @contained_by[bag[2]] << container
          end
        end
      end
    end

    def outer_colours(colour)
      is_contained_by(colour).size
    end

    private def is_contained_by(colour) : Set(String)
      set = @contained_by[colour]
      set.sum(set) { |e| is_contained_by(e) }
    end

    def total_bags(colour)
      bags_inside(colour)
    end

    private def bags_inside(colour) : Int32
      bags = @rule_hash[colour]
      bags.sum(bags.values.sum) { |bag, num| num * bags_inside(bag) }
    end
  end

  extend self

  def run_7_1
    Haversack.new(File.read("#{__DIR__}/input/7.txt")).outer_colours("shiny gold")
  end

  def run_7_2
    Haversack.new(File.read("#{__DIR__}/input/7.txt")).total_bags("shiny gold")
  end
end
