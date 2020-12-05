module AdventOfCode
  class BoardingPass
    getter row : Int32
    getter column : Int32

    def initialize(input)
      numbers = input.gsub({F: '0', B: '1', R: '1', L: '0'})
      @row = numbers[0..6].to_i(2)
      @column = numbers[-3..-1].to_i(2)
    end

    def seat_id
      @row * 8 + @column
    end
  end

  extend self

  def run_5_1
    File.read("#{__DIR__}/input/5.txt").lines.max_of do |line|
      AdventOfCode::BoardingPass.new(line).seat_id
    end
  end

  def run_5_2
    seats = File.read("#{__DIR__}/input/5.txt").lines.map do |line|
      AdventOfCode::BoardingPass.new(line).seat_id
    end
    (Set.new(seats.min..seats.max) - seats).first
  end
end
