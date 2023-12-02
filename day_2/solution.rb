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

  def get_powers
    values.each do |game_id, color_hash_array|
      red = color_hash_array.map { |hash| hash["red"] }.max || 0
      blue = color_hash_array.map { |hash| hash["blue"] }.max || 0
      green = color_hash_array.map { |hash| hash["green"] }.max || 0

      @powers += red*blue*green
    end
  end

  def extract_values
    inputs.each do |line|
      split_line = line.split(":")

      game_id = split_line.first.split(" ").last
      sets = split_line.last.split("; ")
      values[game_id] = []

      sets.each do |set|
        pairs = set.split(", ")
        pairs_hash = { "red" => 0, "green" => 0, "blue" => 0 }
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
end
