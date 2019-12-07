# frozen_string_literal: true

describe Booking do
  let(:short_plane) { ShortAirplane.new }
  let(:booking) { described_class.new(short_plane) }

  describe 'inizialize' do
    it 'receive a plane' do
      expect(described_class.new(short_plane)).to be_a described_class
    end
  end

  describe '#book' do
    it 'returns false if amount is bigger than 8' do
      expect(booking.book('badi', 9)).to be false
    end

    it 'returns false if amount is 0' do
      expect(booking.book('badi', 0)).to be false
    end

    it 'returns false if amount is negative' do
      expect(booking.book('badi', -1)).to be false
    end

    it 'returns false if amount is a float number' do
      expect(booking.book('badi', 2.2)).to be false
    end

    it 'returns false if amount is not a number' do
      expect(booking.book('badi', '321')).to be false
    end
  end
end
