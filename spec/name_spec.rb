require_relative 'spec_helper'
require_relative '../lib/name'

RSpec.describe Name do
  describe '#to_s' do
    subject { described_class.new(raw_name).to_s }

    it 'returns the raw name' do
      expect(subject).to eq raw_name
    end

    let(:raw_name) { 'Ashe (F) - Final Fantasy XII' }
  end

  describe '#to_json' do
    subject { described_class.new(raw_name).to_json }

    it 'returns the expected json' do
      expect(subject).to eq json
    end

    let(:raw_name) { 'Ashe (F) - Final Fantasy XII' }
    let(:json) do
      {
        name: 'Ashe',
        sex: 'F',
        title: 'Final Fantasy XII'
      }.to_json
    end
  end
end
