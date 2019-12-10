# frozen_string_literal: true

describe Seat do
  describe 'to_a' do
    let(:regular_block) do
      SeatBlock.new(rows:  2,
                    names: 'ABC',
                    order: SeatBlock::REGULAR_ORDER)
    end

    let(:inverse_block) do
      SeatBlock.new(rows:  2,
                    names: 'DEF',
                    order: SeatBlock::INVERSE_ORDER)
    end

    let(:dummy_block) { instance_double(SeatBlock) }

    describe '#to_a' do
      it 'return an array' do
        seat = described_class.new(seat_block: dummy_block, row: 1, col: 2)
        expect(seat.to_a).to eq [1, 2]
      end
    end

    describe '#distance_to_windows' do
      context('when regular') do
        it 'returns 0 for windowed seat' do
          seat = described_class.new(seat_block: regular_block,
                                     col:        0,
                                     row:        0)
          expect(seat.distance_to_window).to eq 0
        end

        it 'returns 2 for last seat' do
          seat = described_class.new(seat_block: regular_block,
                                     col:        2,
                                     row:        0)
          expect(seat.distance_to_window).to eq 2
        end
      end

      context('when inverse') do
        it 'returns 0 for windowed seat' do
          seat = described_class.new(seat_block: inverse_block,
                                     col:        2,
                                     row:        0)
          expect(seat.distance_to_window).to eq 0
        end

        it 'returns 2 for last seat' do
          seat = described_class.new(seat_block: inverse_block,
                                     col:        0,
                                     row:        0)
          expect(seat.distance_to_window).to eq 2
        end
      end
    end

    describe '#translate' do
      it 'calls to his matrix translator' do
        dummy = dummy_block
        expect(dummy).to receive(:translate).with([1, 2])

        seat = described_class.new(seat_block: dummy_block,
                                   row: 1, col: 2)
        seat.translate
      end
    end

    describe '#sort #<=>' do
      context('Given two regular matrix') do
        it 'returns first if closer to window' do
          first = described_class.new(seat_block: regular_block,
                                      row: 0, col: 0)
          second = described_class.new(seat_block: regular_block,
                                       row: 0, col: 2)

          expect(first <=> second).to be < 0
          expect(second <=> first).to be > 0
          expect([first, second].min).to eq first
        end

        it 'returns first in row if has the same distance' do
          first = described_class.new(seat_block: regular_block,
                                      row: 1, col: 2)
          second = described_class.new(seat_block: regular_block,
                                       row: 2, col: 2)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([second, first].min).to eq first
        end

        it 'returns zero if equal' do
          first = described_class.new(seat_block: regular_block,
                                      row: 1, col: 2)
          second = described_class.new(seat_block: regular_block,
                                       row: 1, col: 2)

          expect(second <=> first).to be 0
          expect(first <=> second).to be 0
          expect([first, second].min).to eq first
        end
      end

      context('Given two inversed matrix') do
        it 'returns first if closer to window' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        0,
                                      col:        1)

          second = described_class.new(seat_block: inverse_block,
                                       row:        0,
                                       col:        0)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([first, second].min).to eq first
        end

        it 'returns first in row if has the same distance' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        1,
                                      col:        2)
          second = described_class.new(seat_block: inverse_block,
                                       row:        2,
                                       col:        2)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([first, second].min).to eq first
        end

        it 'returns zero if equal' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        1,
                                      col:        2)

          second = described_class.new(seat_block: inverse_block,
                                       row:        1,
                                       col:        2)

          expect(second <=> first).to eq 0
          expect(first <=> second).to eq 0
          expect([first, second].min).to eq first
        end
      end

      context('when comparing mixed kind matrix') do
        it 'returns first if closer to window' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        0,
                                      col:        2)
          second = described_class.new(seat_block: regular_block,
                                       row:        0,
                                       col:        1)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([first, second].min).to eq first
        end

        it 'returns first if closer to window' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        0,
                                      col:        2)
          second = described_class.new(seat_block: regular_block,
                                       row:        0,
                                       col:        1)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([first, second].min).to eq first
        end

        it 'returns first in row if has the same distance' do
          first = described_class.new(seat_block: inverse_block,
                                      row:        1,
                                      col:        2)
          second = described_class.new(seat_block: regular_block,
                                       row:        2,
                                       col:        2)

          expect(second <=> first).to be > 0
          expect(first <=> second).to be < 0
          expect([first, second].min).to eq first
        end

        it 'returns zero if equal' do
          first = described_class.new(seat_block: inverse_block,
                                      row: 1, col: 1)
          second = described_class.new(seat_block: regular_block,
                                       row: 1, col: 1)

          expect(second <=> first).to eq 0
          expect(first <=> second).to eq 0
          expect([first, second].min).to eq first
        end
      end
    end
  end
end
