# frozen_string_literal: true

describe SeatBlock do
  let(:regular) do
    described_class.new(rows:  4,
                        names: 'ABC')
  end

  let(:inverse) do
    described_class.new(rows:  4,
                        names: 'DEF',
                        order: SeatBlock::INVERSE_ORDER)
  end

  describe '#search_by_row' do
    context('for regular matrix') do
      it 'starts by first element when empty' do
        expect(regular.search_by_row(amount: 3)).to eq([0, 0])
      end

      it 'returns the second one if cannot fit on the first' do
        regular.fill_row(row: 0, from: 0, to: 0)
        expect(regular.search_by_row(amount: 3)).to eq([1, 0])
      end

      it 'returns false if not fit' do
        expect(regular.search_by_row(amount: regular.cols + 1)).to be false
      end

      it 'returns false if cannot find any conbination' do
        regular.rows.times do |n|
          regular.fill_row(row: n, from: 0, to: 2)
        end

        expect(regular.search_by_row(amount: 3)).to be false
      end
    end

    context 'when inverse' do
      it 'starts by first element when empty' do
        expect(inverse.search_by_row(amount: 1)).to eq([0, 2])
      end

      it 'returns the last column on the second row fir first is not available' do
        inverse.fill_row(row: 0, from: 2, to: 2)
        expect(inverse.search_by_row(amount: 2)).to eq([1, 1])
      end

      it 'returns false if not fit' do
        expect(inverse.search_by_row(amount: regular.cols + 1)).to be false
      end

      it 'returns false if cannot find any conbination' do
        inverse.rows.times do |n|
          inverse.fill_row(row: n, from: 0, to: 2)
        end

        expect(inverse.search_by_row(amount: 3)).to be false
      end
    end
  end

  describe '#fill_row' do
    it 'returns an array of positions' do
      ret = regular.fill_row(row: 1, from: 1, to: 2)
      expect(ret).to eq [[1, 1], [1, 2]]
    end

    it 'fills row 0 from 0 to 0 with value 2' do
      regular.fill_row(row: 0, from: 0, to: 2, value: 2)
      expect(regular.m.row(0).to_a).to eq [2, 2, 2]
    end

    it 'fills row 3 from 0 to 0' do
      regular.fill_row(row: 3, from: 0, to: 2)
      expect(regular.m.row(3).to_a).to eq [1, 1, 1]
    end

    it 'do not fills previews value on the row' do
      regular.fill_row(row: 3, from: 1, to: 2)
      expect(regular.m.row(3).to_a).to eq [0, 1, 1]
    end

    it 'do not fills the value after' do
      regular.fill_row(row: 3, from: 0, to: 1)
      expect(regular.m.row(3).to_a).to eq [1, 1, 0]
    end
  end

  describe '#free_seats' do
    it 'returns all position where that value is present' do
      regular.rows.times do |n|
        regular.fill_row(row: n, from: 0, to: 1)
      end

      expect(regular.free_seats.size)
        .to eq 4
    end
  end

  describe '#find_positions_for' do
    it 'returns all position where that value is present' do
      regular.rows.times do |n|
        regular.fill_row(row: n, from: 0, to: 1)
      end

      expect(regular.find_positions_for(0).size)
        .to eq 4
    end
  end

  describe '#translate' do
    context 'when regular' do
      it 'returns A1 for 00' do
        expect(regular.translate([0, 0])).to eq 'A1'
      end

      it 'returns B1 for 01' do
        expect(regular.translate([0, 1])).to eq 'B1'
      end

      it 'returns B2 for 11' do
        expect(regular.translate([1, 1])).to eq 'B2'
      end

      it 'returns C1 for 20' do
        expect(regular.translate([0, 2])).to eq 'C1'
      end

      it 'returns C3 for 22' do
        expect(regular.translate([2, 2])).to eq 'C3'
      end
    end

    context 'when inverse' do
      it 'returns D1 for 00' do
        expect(inverse.translate([0, 0])).to eq 'D1'
      end

      it 'returns E1 for 01' do
        expect(inverse.translate([0, 1])).to eq 'E1'
      end

      it 'returns E2 for 11' do
        expect(inverse.translate([1, 1])).to eq 'E2'
      end

      it 'returns F1 for 20' do
        expect(inverse.translate([0, 2])).to eq 'F1'
      end

      it 'returns F3 for 22' do
        expect(inverse.translate([2, 2])).to eq 'F3'
      end
    end
  end

  describe '#inverse' do
    it 'when true set inverse' do
      regular.inverse true
      expect(regular.order).to eq described_class::INVERSE_ORDER
    end

    it 'when false set as regular' do
      inverse.inverse false
      expect(regular.order).to eq described_class::REGULAR_ORDER
    end

    it 'by default is set as regular' do
      expect(described_class.new(rows: 1, names: 'ABC_DCF').order)
        .to eq(described_class::REGULAR_ORDER)
    end
  end
end
