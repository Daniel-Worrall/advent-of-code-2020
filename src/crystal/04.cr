module AdventOfCode
  class Passport
    @values = Hash(String, String).new

    def initialize(input : String)
      input.split(/\s/, remove_empty: true).each do |kv|
        k, v = kv.split(":")
        @values[k] = v
      end
    end

    def valid? : Bool
      [
        @values["byr"]?,
        @values["iyr"]?,
        @values["eyr"]?,
        @values["hgt"]?,
        @values["hcl"]?,
        @values["ecl"]?,
        @values["pid"]?,
        # @values["cid"]?,
      ].all?
    end

    def strict_valid? : Bool
      valid?
      begin
        birth_year = @values["byr"].to_i
        issue_year = @values["iyr"].to_i
        expiration_year = @values["eyr"].to_i
        _, height, height_sym = @values["hgt"].match(/^(\w+)(cm|in)$/).not_nil!
        height = height.to_i
        @values["hcl"].match(/^#([\w|a-f]{6})$/).not_nil![1]
        eye_color = @values["ecl"]
        @values["pid"].match(/^(\w{9})$/).not_nil![1]
      rescue exception
        return false
      end
      [
        birth_year >= 1920,
        birth_year <= 2002,
        issue_year >= 2010,
        issue_year <= 2020,
        expiration_year >= 2020,
        expiration_year <= 2030,
        height >= (height_sym == "cm" ? 150 : 59),
        height <= (height_sym == "cm" ? 193 : 76),
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].includes?(eye_color),
      ].all?
    end
  end

  extend self

  def passports(input) : Array(Passport)
    input.split("\n\n").map do |passport|
      Passport.new(passport)
    end
  end

  def run_4_1
    passports(get_file).count(&.valid?)
  end

  def run_4_2
    passports(get_file).count(&.strict_valid?)
  end
end
