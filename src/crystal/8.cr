module AdventOfCode
  record Instruction, operation : String, value : Int32
  record Result, valid : Bool, acc : Int32

  class Console
    @instructions : Array(Instruction)

    def initialize(lines : String)
      @instructions = lines.lines.map do |line|
        if parse = line.match(/(\w+) \+?(-?\d+)/)
          Instruction.new(parse[1], parse[2].to_i)
        else
          Instruction.new("nop", 0)
        end
      end
    end

    def uncorrupt_run : Result
      original = @instructions.clone
      @instructions.size.times do |line_number|
        op = ""
        case original[line_number].operation
        when "nop"
          op = "jmp"
        when "jmp"
          op = "nop"
        else
          next
        end
        @instructions = original.clone
        @instructions[line_number] = Instruction.new(op, original[line_number].value)
        result = run
        return result if result.valid
      end
      Result.new(false, 0)
    end

    def run(acc = 0) : Result
      run_count = Hash(Int32, Bool).new(false)
      run_line = 0
      instructions_size = @instructions.size
      until run_count[run_line]
        run_count[run_line] = true
        instruction = @instructions[run_line]
        case instruction.operation
        when "acc"
          acc += instruction.value
          run_line += 1
        when "jmp"
          run_line += instruction.value
        else # nop
          run_line += 1
        end
        if run_line >= instructions_size
          return Result.new(true, acc)
        end
      end
      Result.new(false, acc)
    end
  end

  extend self

  def run_8_1
    Console.new(File.read("#{__DIR__}/input/8.txt")).run.acc
  end

  def run_8_2
    Console.new(File.read("#{__DIR__}/input/8.txt")).uncorrupt_run.acc
  end
end
