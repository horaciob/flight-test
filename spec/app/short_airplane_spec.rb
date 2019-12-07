# frozen_string_literal: true

describe ShortAirplane do
  describe 'initialize' do
    let(:sort_airplane) { described_class.new }

    it 'instance a plane with 26 rows' do
      expect(sort_airplane.rows_count).to be 26
    end

    it 'instance a plane with ABC_DEF distribution' do
      expect(sort_airplane.row_arrangement).to eq 'ABC_DEF'
    end
  end
end
