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

  describe '#sex?' do
    subject { described_class.new(raw_name).sex? sex_lookup }

    context 'female' do
      it { is_expected.to eq true }

      let(:sex_lookup) { 'female' }
      let(:raw_name)   { female }
    end

    context 'male' do
      it { is_expected.to eq true }

      let(:sex_lookup) { 'male' }
      let(:raw_name)   { male }
    end

    context 'female does not exist' do
      it { is_expected.to eq false }

      let(:sex_lookup) { 'female' }
      let(:raw_name)   { male }
    end

    context 'male does not exist' do
      it { is_expected.to eq false }

      let(:sex_lookup) { 'male' }
      let(:raw_name)   { female }
    end

    context 'nil is checked against' do
      context 'female' do
        it { is_expected.to eq true }

        let(:raw_name)   { female }
      end

      context 'male' do
        it { is_expected.to eq true }

        let(:raw_name)   { male }
      end

      let(:sex_lookup) { nil }
    end

    let(:female) { 'Ashe (F) - Final Fantasy XII' }
    let(:male)   { 'Basch (M) - Final Fantasy XII' }
  end

  describe '#to_json' do
    subject { described_class.new(raw_name).to_json }

    context 'when a title is included' do
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

    context 'when a title is missing' do
      it 'returns the expected json' do
        expect(subject).to eq json
      end

      let(:raw_name) { 'Ashe (F)' }
      let(:json) do
        {
          name: 'Ashe',
          sex: 'F',
          title: ''
        }.to_json
      end
    end
  end
end
