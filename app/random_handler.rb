# frozen_string_literal: true

class RandomHandler < BookingHandler
  def accept_request(plane, request)
    free_seats = plane.seats_blocks.map(&:free_seats).flatten(1)
    return false if free_seats.size <= request

    seats = free_seats.sample(request)
    ret = []
    seats.each do |position|
      value = position.first.fill_row(row:  position[1],
                                      from: position[2],
                                      to:   position[2])
      ret << position.first.translate(value.first)
    end
    ret
  end
end
