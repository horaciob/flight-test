# frozen_string_literal: true

class Booking
  MAX_BOOK_PER_PERSON = 8

  def initialize(plane)
    @plane = plane
    @manifest = Manifest.new
  end

  def book(name, amount)
    return false unless valid_amount?(amount)

    seats = @plane.reserve(amount)

    @manifest.add(name, seats) if seats
  end

  def show
    puts 'Bookings'
    @manifest.show_resume
    puts 'Result'
    @manifest.show_details
  end

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
