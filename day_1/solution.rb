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
    values = []
    inputs.each do |input|
      input_array = input.split("")
      first_num = first_number(input_array)
      last_num = last_number(input_array)

      values << "#{first_num}#{last_num}".to_i
    end

    values.sum
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
end