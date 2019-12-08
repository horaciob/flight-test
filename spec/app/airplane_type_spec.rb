# frozen_string_literal: true

describe AirplaneType do
  describe '#initialize' do
    let(:sort_airplane) do
      described_class.new(rows:            26,
                          row_arrangement: 'A B C_ D E F')
    end

    it 'creates a new airplane_type' do
      expect(sort_airplane.class).to be described_class
    end

    it 'has 2 seat blocks' do
      expect(sort_airplane.seats_blocks.size).to be 2
    end

    it 'first seat blocks has a regular order' do
      expect(sort_airplane.seats_blocks.first.order).to eq SeatBlock::REGULAR_ORDER
    end

    it 'if middle row has regular order' do
      big_airplane = described_class.new(rows:            26,
                                         row_arrangement: 'A B C _ D E F G _ H I J')
      expect(big_airplane.seats_blocks[1].order).to eq SeatBlock::REGULAR_ORDER
    end

    it 'last seat blocks has an inverse  order' do
      expect(sort_airplane.seats_blocks.last.order).to eq SeatBlock::INVERSE_ORDER
    end
  end

  describe "#reserve" do
    it 'raise an error if not implemented' do 
      airplane = described_class.new(rows:1,row_arrangement:"A_B")
      expect{airplane.reserve(2)}.to raise_error NotImplementedError
    end
  end
end
