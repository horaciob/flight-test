# frozen_string_literal: true

class RowHandler < BookingHandler
  def accept_request(plane, amount)
    # TODO: Will work for short_airplane, I have to iterate over aircraft type
    # seat block to support ABC_DEFG_HIJ or generic

    ret = []
    left = plane.seats_blocks.first.search_by_row(amount: amount)
    right = plane.seats_blocks.last.search_by_row(amount: amount)
    if left
      ret << Seat.new(seat_block: plane.seats_blocks.first,
                      row: left[0], col: left[1])
    end

    if right
      ret << Seat.new(seat_block: plane.seats_blocks.last,
                      row: right[0], col: right[1] + amount - 1)
    end
    return false if ret.empty?

    best = ret.min
    ret = best.seat_block.fill_row(row: best.row,
                                 from: best.col, amount: amount)
    ret.map(&:translate)
  end
end
