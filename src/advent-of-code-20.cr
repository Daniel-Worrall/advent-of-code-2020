require "./crystal/**"
require "option_parser"
require "benchmark"

module AdventOfCode
  def self.get_file(call_file = __FILE__) : String
    if digits = call_file.match(/(\d+).cr/)
      get_file(digits[1].to_i)
    else
      raise "No matched file"
    end
  end

  def self.get_file(input : Int32) : String
    File.read("#{__DIR__}/input/#{input}.txt")
  end
end

macro print_method(method)
  print {{ method[4..method.size].gsub(/_/, ".") }}, ": ", AdventOfCode.{{ method.id }}, "\n"
end

all = false
OptionParser.parse do |parser|
  parser.banner = "Usage: advent-of-code-20 [arguments]"

  parser.on("-a", "--all", "Runs all solutions") do
    {% for method, _index in AdventOfCode.methods.map(&.name.stringify).select { |name| name =~ /run_(\d+_\d)/ } %}
      print_method({{method}})
    {% end %}
  end

  parser.on("-r NAME", "--run=NAME", "Specifies the code to run. Supports regex") do |parse|
    next if all
    {% for method, _index in AdventOfCode.methods.map(&.name.stringify).select { |name| name =~ /run_(\d+_\d)/ } %}
      if {{ method[4..method.size].gsub(/_/, ".") }} =~ Regex.new(parse)
        print_method({{method}})
      end
    {% end %}
  end

  parser.on("-bm", "--benchmark", "Benchmarks the solutions.") do
    Benchmark.bm do |x|
      {% for method, _index in AdventOfCode.methods.map(&.name.stringify).select { |name| name =~ /run_(\d+_\d)/ } %}
        x.report({{method.stringify}}) do
          AdventOfCode.{{method.id}}
        end
      {% end %}
    end
  end

  parser.on("-h", "--help", "Show this help") { puts parser }
  parser.invalid_option do |invalid_option|
    STDERR.puts "ERROR: #{invalid_option} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
  parser.missing_option do |missing_option|
    STDERR.puts "ERROR: #{missing_option} missing option."
    STDERR.puts parser
    exit(1)
  end
end
