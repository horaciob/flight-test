# frozen_string_literal: true

describe BookingHandler do
  class TrueHandler < BookingHandler
    def accept_request(_value)
      true
    end
  end

  class FalseHandler < BookingHandler
    def accept_request(_value)
      false
    end
  end

  describe '#process_request' do
    it 'Calls accept_request' do
      handler = FalseHandler.new

      expect(handler).to receive(:accept_request).with('arg')
                                                 .once.and_call_original

      handler.process_request('arg')
    end

    it 'Calls handlers in the middle ' do
      third_handler = TrueHandler.new
      second_handler = FalseHandler.new third_handler
      first_handler = FalseHandler.new second_handler

      expect(second_handler).to receive(:process_request)
        .once.and_call_original

      first_handler.process_request('fake')
    end

    it 'returns the return value of the handler that is able to attend the request' do
      last_handler = TrueHandler.new
      second_handler = FalseHandler.new last_handler
      handler = FalseHandler.new second_handler

      expect(handler.process_request('fake')).to be true
    end

    it 'Don\'t call to last_handler if some handler has response the request' do
      last_handler = TrueHandler.new
      second_handler = TrueHandler.new last_handler
      handler = FalseHandler.new second_handler

      expect(last_handler).not_to receive(:process_request)
      handler.process_request('fake')
    end

    it 'return nil if nobody handle this request' do
      expect(FalseHandler.new.process_request('fake')).to be nil
    end
  end

  describe '#accept_request' do
    context 'when not implemented' do
      it 'Throw exception' do
        expect { described_class.new.accept_request('something') }
          .to raise_exception(NotImplementedError)
      end
    end
  end
end
