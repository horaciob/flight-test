# frozen_string_literal: true

class AirplaneType
  FREE_SEATS_MASK = 0
  AISLE_SEAT_MASK = -1
  AISLE_CHAR_MASK = '_'
  
  attr_reader :rows_count, :rows_arrangement
  def initialize(rows:, row_arrangement:)
    @rows_count = rows
    @rows_arrangement = row_arrangement.gsub(' ', '')
  end

  def seats
    @seats ||= seats_struct
  end

  def debug
    seats.each do |row|
      row.each do |s|
        fancy_char = AISLE_SEAT_MASK == s ? "     " : s.to_s
        print fancy_char
      end
      print "\n"
    end
    ""
  end

  def sits_per_row
    @sits_per_row ||= @rows_arrangement.scan(/[A-Z]/).size
  end

  def sits_count
    @rows_count * sits_per_row
  end

  private

  def seats_struct
    ret = []
    @rows_count.times do
      ret << empty_row
    end

    ret
  end

  def empty_row
    @rows_arrangement.chars.map do |c|
      c == AISLE_CHAR_MASK ? AISLE_SEAT_MASK : FREE_SEATS_MASK
    end
  end
end
