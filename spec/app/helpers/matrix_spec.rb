# frozen_string_literal: true

describe Helpers::Matrix do
  let(:dummy_class) do
    Class.new do
      include Helpers::Matrix
      attr_accessor :m
      def initialize(m)
        @m = m
      end
    end
  end

  describe '#fit_by_row' do
    let(:dummy_short) do
      dummy_class.new([[0, 0, 0, AirplaneType::AISLE_SEAT_MASK, 0, 0, 0],
                       [0, 0, 0, AirplaneType::AISLE_SEAT_MASK, 0, 0, 0],
                       [0, 0, 0, AirplaneType::AISLE_SEAT_MASK, 0, 0, 0]])

    end

    context 'when aisle' do
      it 'for 1 returns 00' do
        ret = dummy_short.fit_by_row(dummy_short.m, 1, mark_with: 1)

        expect(ret).to include([0,0])
      end

      it 'for 1 returns 00' do
        dummy_short.m[0][0]=1
        dummy_short.m[1][0]=1
        
        ret = dummy_short.fit_by_row(dummy_short.m, 1, mark_with: 1)
        byebug
        expect(ret).to include([0,0])
      end

      it 'for 2 returns 00 and 01' do
        ret = dummy_short.fit_by_row(dummy_short.m, 2, mark_with: 1)
        expect(ret).to include([0,0],[0,1])
      end

      it 'for 2 returns 06 and 05 if 00 is taken' do
        ret = dummy_short.fit_by_row(dummy_short.m, 2, mark_with: 1)
        expect(ret).to include([0,0],[0,1])
      end
    end
  end
end
