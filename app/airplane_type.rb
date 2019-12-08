# frozen_string_literal: true

class AirplaneType
  FREE_SEATS_MASK = 0
  AISLE_SEAT_MASK = -1
  AISLE_CHAR_MASK = '_'

  attr_reader :rows_count, :row_arrangement, :seats_blocks

  def initialize(rows:, row_arrangement:)
    @rows_count = rows
    @row_arrangement = row_arrangement.gsub(' ', '')

    @seats_blocks = @row_arrangement.split(AISLE_CHAR_MASK).map do |name|
      SeatBlock.new(rows: @rows_count, names: name)
    end

    @seats_blocks.last.inverse true if @seats_blocks.size > 1
  end

  def reserve(_amount)
    raise NotImplementedError, "#{self.class} must implement reserve method"
  end
end
