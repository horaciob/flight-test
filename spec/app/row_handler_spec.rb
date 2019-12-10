# frozen_string_literal: true

describe RowHandler do
  let(:short_plane) { ShortAirplane.new }

  describe 'accept_request' do
    it 'if empty returns A1, B1' do
      handler = described_class.new
      expect(handler.accept_request(short_plane, 2))
        .to eq(%w[A1 B1])
    end

    it 'if A1, B1 are taken take D1 and F1' do
      handler = described_class.new
      handler.accept_request(short_plane, 2)
      expect(handler.accept_request(short_plane, 2))
        .to eq(%w[E1 F1])
    end

    it 'return false if cannot allocate in a row' do
      handler = described_class.new

      expect(handler.accept_request(short_plane, 4))
        .to eq(false)
    end
  end
end
