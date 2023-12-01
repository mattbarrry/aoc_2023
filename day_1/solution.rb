# The newly-improved calibration document consists of lines of text; each line originally contained a specific
# calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining
# the first digit and the last digit (in that order) to form a single two-digit number.
#
# For example:
#
# 1abc2
# pqr3stu8vwx
# a1b2c3d4e5f
# treb7uchet
#
# In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
#
# Consider your entire calibration document. What is the sum of all of the calibration values?

class Solution
  attr_reader :inputs

  def initialize(file_name)
    @inputs = File.read(file_name).split(/\r?\n|\r/).map { |line| line }
  end

  def solve
    inputs.map { |input| extract_value(treat_string(input)) }.sum
  end

  private

  def extract_value(treated_input)
    numbers = treated_input.split("")
    "#{first_number(numbers)}#{last_number(numbers)}".to_i
  end

  def first_number(input_array)
    input_array.each do |i|
      return i if Float(i) != nil rescue false
    end
  end

  def last_number(input_array)
    input_array.reverse.each do |i|
      return i if Float(i) != nil rescue false
    end
  end

  def treat_string(input_string)
    num_map.each { |k, v| input_string.gsub!(/#{k}/, "#{k}#{v}#{k}") }

    input_string
  end

  def num_map
    {
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }
  end
end
