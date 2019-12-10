# frozen_string_literal: true

class ShortAirplane < AirplaneType
  def initialize
    super(rows: 26, row_arrangement: 'ABC_DEF')
  end

  def reserve(amount)
    random = RandomHandler.new
    handler = RowHandler.new(random)
    handler.process_request(self, amount)
  end
end
