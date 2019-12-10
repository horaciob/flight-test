# frozen_string_literal: true

class RandomHandler < BookingHandler
  def accept_request(plane, request)
    free_seats = plane.seats_blocks.map(&:free_seats).flatten(1)
    return false if free_seats.size <= request

    seats = free_seats.sample(request)
    ret = []
    seats.each do |seat|
      booked_seat = seat.seat_block.fill_row(row:  seat.row,
                                             from: seat.col)
      ret << booked_seat.first.translate
    end
    ret
  end
end
