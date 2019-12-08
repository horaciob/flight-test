# frozen_string_literal: true

require 'matrix'

class SeatBlock
  class OutOfPositionError < StandardError; end
  REGULAR_ORDER = 0
  INVERSE_ORDER = 1

  attr_reader :m, :rows, :cols, :order

  def initialize(rows:, names:, order: REGULAR_ORDER)
    @col_name = names
    @rows = rows
    @cols = names.size
    @order = order
    @m = Matrix.zero(@rows, @cols)
  end

  # find the best row location
  def search_by_row(amount: 1)
    return false if amount > @cols

    # TODO: I have to take a look if there is better way to do this
    # maybe with transpose or some Enumerator or matrix iterator
    r = (0..@cols - amount)
    r = (@cols - amount).downto(0) if @order == INVERSE_ORDER

    r.each do |col|
      @rows.times do |row|
        return [row, col] if fits_in_row?(row: row, from: col, amount: amount)
      end
    end
    false
  end

  # Fills a from from a position to a position with some value
  # returns an array of position that can be translated after
  def fill_row(row:, from:, to:, value: 1)
    raise OutPositionException if to >= row.size

    ret = []
    (from..to).each do |x|
      @m[row, x] = value
      ret << [row, x]
    end

    ret
  end

  def translate(position)
    "#{@col_name[position.last]}#{position.first + 1}"
  end

  def inverse(flag)
    @order = flag ? INVERSE_ORDER : REGULAR_ORDER
  end

  private

  def fits_in_row?(row:, from:, amount:)
    @m.row(row)[from..from + amount - 1].count(0) == amount
  end
end
