# frozen_string_literal: true

describe Manifest do
  describe '#add' do
    it 'allows to add new user' do
      m = Manifest.new
      m.add('Horacio', %w[A1 B1])
      expect(m.list).to eq [['Horacio', %w[A1 B1]]]
    end
  end

  describe '#show resume' do
    it 'show users descriptions' do
      m = Manifest.new
      m.add('Horacio', %w[A1 B1])
      expect { m.show_resume }.to output(/\Horacio: 2 people/).to_stdout
    end

    it 'show singular when is just 1 book' do
      m = Manifest.new
      m.add('Horacio', %w[A1])
      expect { m.show_resume }.to output(/\Horacio: 1 person/).to_stdout
    end
  end

  describe '#show details' do
    it 'show users descriptions' do
      m = Manifest.new
      m.add('Horacio', %w[A1 B1])
      expect { m.show_details }.to output("* Horacio seats: A1, B1\n").to_stdout
    end
  end
end
