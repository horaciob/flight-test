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

  describe '#reserve' do
    context 'creates a chain of strategies that will run in order' do
      it 'Row handler should receive process_request message' do
        handler = instance_double(RowHandler)
        allow(RowHandler).to receive(:new).and_return(handler)
        expect(handler).to receive(:process_request)
          .with(instance_of(ShortAirplane), 2)

        described_class.new.reserve(2)
      end

      it "Random handler has to be the Row handler's successor" do
        expect(RowHandler).to receive(:new)
          .with(instance_of(RandomHandler)).and_call_original

        described_class.new.reserve(2)
      end
    end
  end
end
