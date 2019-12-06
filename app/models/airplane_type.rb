# frozen_string_literal: true

class AirplaneType
  FREE_SEATS_MASK = 0
  AISLE_SEAT_MASK = -1
  AISLE_CHAR_MASK = '_'

  def initialize(rows:, row_arrangement:)
    @rows_count = rows
    @rows_arrangement = row_arrangement.gsub(' ', '')
  end

  def seats
    @seats ||= seats_struct
  end

  def pretty_show
    @seats.each
  end

  def sits_per_row
    @sits_per_row ||= @rows_arrangement.scan(/[A-Z]/).size
  end

  def sits_count
    @rows_count * sits_per_row
  end

  private

  def seats_struct
    Array.new(@rows_count, empty_row)
  end

  def empty_row
    @rows_arrangement.chars.map do |c|
      c == AISLE_CHAR_MASK ? AISLE_SEAT_MASK : FREE_SEATS_MASK
    end
  end
end
