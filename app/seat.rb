# frozen_string_literal: true

class Seat
  attr_reader :seat_block, :row, :col
  def initialize(seat_block:, row:, col:)
    @row = row
    @col = col
    @seat_block = seat_block
  end

  def translate
    @seat_block.translate([@row, @col])
  end

  def distance_to_window
    return @col unless @seat_block.inverse?

    @seat_block.cols - 1 - @col
  end

  def to_a
    [@row, @col]
  end

  def <=>(other)
    diff = distance_to_window - other.distance_to_window
    if diff.zero?
      return @row - other.row # if it has same distance checks row
    end

    diff
  end
end
