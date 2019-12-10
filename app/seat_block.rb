# frozen_string_literal: true

require 'matrix'

class SeatBlock
  class OutOfPositionError < StandardError; end
  FREE_SEATS_MASK = 0
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
  def fill_row(row:, from:, amount: 1, value: 1)
    enumerator = if @order == REGULAR_ORDER
                   to = from + amount - 1
                   (from..to)
                 else
                   (from - amount + 1..from)
                 end

    enumerator.map do |column|
      @m[row, column] = value
      Seat.new(seat_block: self, row: row, col: column)
    end
  end

  def free_seats
    find_positions_for(FREE_SEATS_MASK)
  end

  def find_positions_for(value)
    ret = []

    @m.each_with_index do |v, row, col|
      ret << Seat.new(seat_block: self, row: row, col: col) if v == value
    end

    ret
  end

  def translate(position)
    "#{@col_name[position.last]}#{position.first + 1}"
  end

  def inverse(flag)
    @order = flag ? INVERSE_ORDER : REGULAR_ORDER
  end

  def inverse?
    @order == INVERSE_ORDER
  end

  private

  def fits_in_row?(row:, from:, amount:)
    @m.row(row)[from..from + amount - 1].count(FREE_SEATS_MASK) == amount
  end
end
