# frozen_string_literal: true

describe Manifest
describe '#add' do
  it 'allows to add new user' do
    m = Manifest.new
    m.add('Horacio', %w[A1 B1])
    expect(m.list).to eq [['Horacio', %w[A1 B1]]]
  end
end
