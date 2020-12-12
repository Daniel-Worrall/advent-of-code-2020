module AdventOfCode
  class Ferry
    alias Seat = Tuple(Int32, Int32)

    @seats : Hash(Seat, Bool)
    @x_max : Int32
    @y_max : Int32
    @directions : Array(Seat) = [-1, 0, 1].product([-1, 0, 1]).reject { |dx, dy| dx == 0 && dy == 0 }

    def initialize(input : String)
      lines = input.lines
      @x_max = lines.first.size
      @y_max = lines.size
      @seats = Hash(Seat, Bool).new(initial_capacity: (input.size - @y_max + 1))
      lines.each_with_index do |line, y|
        line.chars.each_with_index do |e, x|
          @seats[{x, y}] = case e
                           when 'L'
                             false
                           when '#'
                             true
                           else
                             next
                           end
        end
      end
    end

    def seating_one(iterations = nil)
      iterate(iterations, 4, get_seats(&->adjacent_seats(Seat)))
      self
    end

    def seating_two(iterations = nil)
      iterate(iterations, 5, get_seats(&->visible_seats(Seat)))
      self
    end

    def seats_filled
      @seats.values.count(&.itself)
    end

    def print_seats
      (0...@max_y).each do |y|
        (0...@max_x).each do |x|
          if @seats.has_key?({x, y})
            key = @seats[{x, y}]
            print key ? '#' : 'L'
          else
            print '.'
          end
        end
        print '\n'
      end
      print '\n'
    end

    private def get_seats(&block)
      @seats.reduce(Hash(Seat, Array(Seat)).new(initial_capacity: @seats.size)) do |hash, (seat, _)|
        hash[seat] = yield(seat)
        hash
      end
    end

    private def iterate(iterations, tolerance, seat_map)
      loop do
        previous_iteration = @seats.dup

        previous_iteration.each do |(k, v)|
          case {v, seat_map[k].count(&->previous_iteration.[]?(Seat))}
          when {true, .>=(tolerance)}
            @seats[k] = false
          when {false, .==(0)}
            @seats[k] = true
          end
        end

        iterations -= 1 if iterations
        break seats_filled if previous_iteration == @seats || iterations && iterations == 0
      end
    end

    private def adjacent_seats(seat : Seat) : Array(Seat)
      @directions.each
        .select { |(dx, dy)| @seats.has_key?({seat[0] + dx, seat[1] + dy}) }
        .map { |(dx, dy)| {seat[0] + dx, seat[1] + dy} }
        .to_a
    end

    private def visible_seats(seat : Seat) : Array(Seat)
      @directions.each.map do |(dx, dy)|
        x = seat[0]
        y = seat[1]
        loop do
          break unless 0 <= x < @x_max && 0 <= y < @y_max
          x += dx
          y += dy
          break {x, y} if @seats.has_key?({x, y})
        end
      end
        .reject(&.nil?)
        .map(&.not_nil!)
        .to_a
    end
  end

  extend self

  def run_11_1
    Ferry.new(get_file).seating_one.seats_filled
  end

  def run_11_2
    Ferry.new(get_file).seating_two.seats_filled
  end
end
