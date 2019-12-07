# frozen_string_literal: true

class ShortAirplane < AirplaneType
  def initialize
    super(rows: 26, row_arrangement: 'ABC_DEF')
  end
end
