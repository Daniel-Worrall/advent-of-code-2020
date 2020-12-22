module AdventOfCode
  class Tickets
    alias Rule = Range(Int32, Int32)
    alias Ticket = Array(Int32)

    @rules : Hash(String, Array(Rule))
    @ticket : Ticket
    @nearby : Array(Ticket)

    def initialize(input)
      rules, ticket, nearby = input.split("\n\n")
      @rules = rules.lines.to_h do |rule|
        key, rule = rule.split(":")
        values = rule.strip.split(" or ").map do |range|
          from, to = range.split("-")
          Range.new(from.to_i, to.to_i)
        end
        {key, values}
      end
      @ticket = ticket.lines.last.split(",").map(&.to_i)
      @nearby = nearby.lines.skip(1).map(&.split(',').map(&.to_i))
    end

    def error_rate
      rules = flat_rules
      @nearby.each.flatten.sum do |num|
        rules.any?(&.includes?(num)) ? 0 : num
      end
    end

    def departure_product
      any_rules = merge_ranges(@rules.values.flatten)
      all_rules = range_set_intersection(@rules.values)

      all = (0...@rules.keys.size).to_set

      translation = @rules.to_h { |k, _| {k, all.dup} }
      found = Hash(Int32, String).new

      valid_tickets = @nearby.select(&.all? { |num| any_rules.any?(&.includes?(num)) }).to_a
      x = 0
      until translation.size == 0 || (x += 1) == 4
        valid_tickets.each do |ticket|
          ticket.each
            .with_index.reject { |(num, i)| found.has_key?(i) || all_rules.any?(&.includes?(num)) }
            .each do |num, i|
              @rules.reject(found.values).each do |field, rules|
                next if rules.any?(&.includes?(num))
                translation[field].delete(i)
                if translation[field].size == 1
                  found_index = translation[field].first
                  found[found_index] = field
                  translation.each do |_, v|
                    v.delete(found_index)
                  end
                  translation.delete(field)
                end
              end
            end
        end
        translation.each do |field, set|
          if set.size == 1
            found_index = translation[field].first
            found[found_index] = field
            translation.each do |_, v|
              v.delete(found_index)
            end
            translation.delete(field)
          end
        end
      end
      invert = found.invert
      invert.select(&.starts_with?("departure")).product(1_i64){ |_, index| @ticket[index] }
    end

    private def flat_rules
      @rules.values.flatten.sort { |a, b| a.begin == b.begin ? a.end <=> b.end : a.begin <=> b.begin }
        .slice_when { |i, j| i.end < j.begin }
        .map { |arr| arr.first.begin..arr.last.end }
        .to_a
    end

    private def merge_ranges(ranges)
      @rules.values.flatten.sort { |a, b| a.begin == b.begin ? a.end <=> b.end : a.begin <=> b.begin }
        .slice_when { |i, j| i.end < j.begin }
        .map { |arr| arr.first.begin..arr.last.end }
        .to_a
    end

    # We assume the ranges sets are presorted which they are in our case
    private def range_set_intersection(range_sets) forall B, E
      range_sets.reduce do |acc, b|
        arr = acc.class.new
        acc.each do |a_range|
          b.each do |b_range|
            if a_range.end < b_range.begin || b_range.end < a_range.begin
              next
            else
              arr << (Math.max(a_range.begin, b_range.begin)..Math.min(a_range.end, b_range.end))
            end
          end
        end
        arr
      end
    end
  end

  extend self

  def run_16_1
    Tickets.new(get_file).error_rate
  end

  def run_16_2
    Tickets.new(get_file).departure_product
  end
end
