# frozen_string_literal: true

# BookingHandler class acts as the
# Handler for implementation of
# Chain of Responsibility pattern.
class BookingHandler
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def process_request(plane, request)
    ret = accept_request(plane, request)
    if ret
      ret
    elsif @successor
      @successor.process_request(plane, request)
    else
      fail_request(plane, request)
    end
  end

  def fail_request(_plane, _request)
    puts 'Seats could not be assigned'
    nil
  end

  def accept_request(_plane, _request)
    raise NotImplementedError, '#accept_request method must be implemented.'
  end
end
