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

  NUM_MAP = {
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }.freeze

  def initialize(file_name)
    @inputs = File.readlines(file_name).map(&:chomp)
  end

  def solve
    inputs.map { |input| extract_value(treat_string(input)) }.sum
  end

  private

  def extract_value(treated_input)
    numbers = treated_input.split("").select { |item| numeric? item }
    "#{numbers.first}#{numbers.last}".to_i
  end

  def numeric?(input)
    Float(input) != nil rescue false
  end

  # this weird gsub accounts for numbers "sharing" a letter, such as "eightwothree", where eight and two share the t
  def treat_string(input_string)
    NUM_MAP.each { |k, v| input_string.gsub!(/#{k}/, "#{k}#{v}#{k}") }

    input_string
  end
end
