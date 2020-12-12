module AdventOfCode
  class Navigation
    record Position, x : Int32, y : Int32 do
      def *(value)
        Position.new(x * value, y * value)
      end

      def +(position : Position)
        Position.new(x + position.x, y + position.y)
      end

      def rotate(num)
        case num
        when 0 then self
        when 1 then Position.new(y, -x)
        when 2 then Position.new(-x, -y)
        when 3 then Position.new(-y, x)
        else
          raise "rotation between 0 and 3"
        end
      end
    end

    DIRECTIONS = {
      'N' => Position.new(0, 1),
      'E' => Position.new(1, 0),
      'S' => Position.new(0, -1),
      'W' => Position.new(-1, 0),
    }

    getter ship = Position.new(0, 0)
    getter wp = Position.new(10, 1)
    @steps = 0
    @directions = ['N', 'E', 'S', 'W']
    @facing = 1

    def initialize(@input : String)
    end

    def navigate(iterations = nil)
      if iterations
        run_navigate(@input.lines[@steps..(iterations - 1 + @steps)])
        @steps += iterations
      else
        run_navigate(@input.lines)
      end
      self
    end

    def navigate_waypoint(iterations = nil)
      if iterations
        run_waypoint(@input.lines[@steps..(iterations - 1 + @steps)])
        @steps += iterations
      else
        run_waypoint(@input.lines)
      end
      self
    end

    def manhatten
      @ship.x.abs + @ship.y.abs
    end

    private def run_navigate(instructions : Array(String))
      instructions.each do |action|
        value = action[1..].to_i
        case char = action[0]
        when .in?(DIRECTIONS.keys)
          @ship += DIRECTIONS[char] * value
        when 'F'
          @ship += DIRECTIONS[@directions[@facing]] * value
        else
          rotation = char == 'R' ? 1 : -1
          @facing = (@facing + value // 90 * rotation) % 4
        end
      end
    end

    private def run_waypoint(instructions : Array(String))
      instructions.each do |action|
        value = action[1..].to_i
        case char = action[0]
        when .in?(DIRECTIONS.keys)
          @wp += DIRECTIONS[char] * value
        when 'F'
          @ship += @wp * value
        else
          rotation = char == 'R' ? 1 : -1
          @wp = @wp.rotate((value // 90 * rotation) % 4)
        end
      end
    end
  end

  extend self

  def run_12_1
    Navigation.new(get_file).navigate.manhatten
  end

  def run_12_2
    Navigation.new(get_file).navigate_waypoint.manhatten
  end
end
