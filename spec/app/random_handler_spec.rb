# frozen_string_literal: true

describe RandomHandler do
  let(:short_plane) { ShortAirplane.new }
  let(:booking) { Booking.new(:short_plane) }

  describe '#accept_request' do
    it 'returns two  seats if available' do
      handler = described_class.new
      expect(handler.accept_request(short_plane, 2).size).to be 2
    end

    it 'returns false if cannot find the amount' do
      handler = described_class.new
      expect(handler.accept_request(short_plane, 200)).to be false
    end
  end
end
