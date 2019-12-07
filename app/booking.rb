# frozen_string_literal: true

class Booking
  MAX_BOOK_PER_PERSON = 8

  def initialize(plane)
    @plane = plane
    @books = []
  end

  def book(_name, amount)
    return false unless valid_amount?(amount)
    # TODO
  end

  def show; end

  private

  def valid_amount?(amount)
    return false if amount.class == Float

    if (1..MAX_BOOK_PER_PERSON).include?(amount)
      true
    else
      puts "Value #{amount} its not allowed"
      false
    end
  end
end
