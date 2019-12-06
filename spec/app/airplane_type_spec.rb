# frozen_string_literal: true

describe AirplaneType do
  describe '#seats' do
    context 'when ABC_DEF' do
      let(:plane) { described_class.new(rows: 2, row_arrangement: 'ABC_DEF') }

      it 'has 2 rows' do
        expect(plane.seats.size).to be 2
      end

      it 'has 7 columns' do
        expect(plane.seats.first.size).to be 7
      end

      it 'has 1 aisle' do
        expect(plane.seats.first.count(described_class::AISLE_SEAT_MASK))
          .to be 1
      end
    end
  end

  describe '.sits_count' do
    it 'for arragment ABC_DEF and 26 row returns 156' do
      aircraft = described_class.new(rows: 26, row_arrangement: 'ABC_DEF')
      expect(aircraft.sits_count).to eq 156
    end
  end

  describe '.sits_count' do
    it 'for arragment ABC_DEF and 26 row returns 156' do
      aircraft = described_class.new(rows: 26, row_arrangement: 'ABC_DEF')
      expect(aircraft.sits_count).to eq 156
    end
  end

  describe 'sits_per_row' do
    it 'returns 6 for ABC_DEF' do
      aircraft = described_class.new(rows: 26, row_arrangement: 'ABC_DEF')
      expect(aircraft.sits_per_row).to eq 6
    end

    it 'returns 3 for ABC' do
      aircraft = described_class.new(rows: 26, row_arrangement: 'ABC_DEF')
      expect(aircraft.sits_per_row).to eq 6
    end

    it 'returns 9 for ABC_DEF_GHI' do
      aircraft = described_class.new(rows: 26, row_arrangement: 'ABC_DEF_GHI')
      expect(aircraft.sits_per_row).to eq 9
    end
  end
end
