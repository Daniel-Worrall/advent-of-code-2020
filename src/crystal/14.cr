module AdventOfCode
  class BitMasks
    @mask : String = "X" * 36
    @memory = {} of Int64 => Int64

    def initialize(@input : String)
    end

    def run(input = nil)
      to_parse = input ? input : @input
      to_parse.each_line do |line|
        parse_line(line)
      end
      self
    end

    def run_v2(input = nil)
      to_parse = input ? input : @input
      to_parse.each_line do |line|
        parse_line_v2(line)
      end
      self
    end

    def sum
      @memory.values.sum
    end

    private def parse_line(line)
      if parse = line.match(/^(\w+)(?:\[(\d+)\])? = (\w+)$/)
        case parse[1]
        when "mem"
          or = @mask.gsub('X', '0').lstrip('0').to_i64(2) { 0_i64 }
          not = Int64::MAX - @mask.gsub({'1' => "0", '0' => '1', 'X' => '0'}).lstrip('0').to_i64(2) { 0_i64 }
          num = (parse[3].to_i64 | or) & not
          @memory[parse[2].to_i64] = num
        when "mask"
          @mask = parse[3]
        else
          raise "Unmatched #{parse[1]}"
        end
      else
        raise "Unparsed #{line}"
      end
    end

    private def parse_line_v2(line)
      if parse = line.match(/^(\w+)(?:\[(\d+)\])? = (\w+)$/)
        case parse[1]
        when "mem"
          arr = @mask.chars.reverse
            .each.with_index
            .select(&.[](0).==('X'))
            .map(&.[](1))
            .reduce([0_i64]) do |acc, i|
              acc.dup.each do |j|
                acc << (2_i64**i + j)
              end
              acc
            end
          or = @mask.gsub('X', '0').lstrip('0').to_i64(2) { 0_i64 }
          not = Int64::MAX - @mask.gsub({'1' => "0", 'X' => '1'}).lstrip('0').to_i64(2) { 0_i64 }
          num = parse[3].to_i64
          memory = (parse[2].to_i64 | or) & not
          arr.each do |mem_mask|
            to_set = memory | mem_mask
            @memory[to_set] = num
          end
        when "mask"
          @mask = parse[3]
        else
          raise "Unmatched #{parse[1]}"
        end
      else
        raise "Unparsed #{line}"
      end
    end
  end

  extend self

  def run_14_1
    BitMasks.new(get_file).run.sum
  end

  def run_14_2
    BitMasks.new(get_file).run_v2.sum
  end
end
