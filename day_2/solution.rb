class Solution
  attr_reader :inputs
  attr_accessor :values, :winning_game_sum, :powers

  MAXIMUMS = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }.freeze

  def initialize(file_name)
    @inputs = File.readlines(file_name).map(&:chomp)
    @values = {}
    @winning_game_sum = 0
    @powers = 0
  end

  def solve
    extract_values
    get_powers
    check_vals_against_maximums
  end

  private

  def extract_values
    inputs.each do |line|
      split_line = line.split(":")

      game_id = split_line.first.split(" ").last
      sets = split_line.last.split("; ")
      values[game_id] = []

      sets.each do |set|
        pairs = set.split(", ")
        pairs_hash = MAXIMUMS.keys.each_with_object({}) { |color, hash| hash[color] = 0 }
        pairs.each do |pair|
          num = pair.split(" ").first.to_i
          color = pair.split(" ").last

          pairs_hash[color] = num
        end

        values[game_id] << pairs_hash
      end
    end
  end

  def check_vals_against_maximums
    values.each do |game_id, color_hash_array|
      color_hash_array.each do |color_hash|
        MAXIMUMS.each do |col, max|
          values.delete(game_id) if color_hash[col] > max
        end
      end
    end

    @winning_game_sum = values.keys.map(&:to_i).sum
  end

  def get_powers
    values.each do |game_id, color_hash_array|
      @powers += calculate_power(color_hash_array)
    end
  end

  def calculate_power(array)
    colors = MAXIMUMS.keys
    colors.map { |color| array.map { |hash| hash[color] }.max || 0 }.reduce(:*)
  end
end
