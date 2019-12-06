# frozen_string_literal: true

# BookingHandler class acts as the
# Handler for implementation of
# Chain of Responsibility pattern.
class BookingHandler
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def process_request(request)
    ret = accept_request(request)
    if ret
      ret
    elsif @successor
      @successor.process_request(request)
    else
      fail_request(request)
    end
  end

  def fail_request(_request)
    puts 'Seats could not be assigned'
    nil
  end

  def accept_request(_request)
    raise NotImplementedError, '#accept_request method must be implemented.'
  end
end
