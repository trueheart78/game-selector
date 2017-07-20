require_relative 'spec_helper'
require_relative '../lib/game'

RSpec.describe Game do
  describe '#to_s' do
    subject { described_class.new(raw_name).to_s }

    it 'returns the passed game name' do
      expect(subject).to eq raw_name
    end
  end

  describe '#title' do
    subject { described_class.new(raw_name).title }

    it 'returns the title game title' do
      expect(subject).to eq title
    end
  end

  describe '#tags' do
    subject { described_class.new(raw_name).tags }

    it 'returns the related tags' do
      expect(subject).to eq %w[Vita PS4]
    end
  end

  describe '#to_json' do
    subject { described_class.new(raw_name).to_json }

    context 'when tags are included' do
      it 'returns the expected json' do
        expect(subject).to eq json
      end

      let(:tag) { '(Vita/PS4)' }
      let(:json) do
        {
          game:   raw_name,
          title:  title,
          tags:   ['Vita', 'PS4']
        }.to_json
      end
    end

    context 'when tags are missing' do
      it 'returns the expected json' do
        expect(subject).to eq json
      end

      let(:tag) { '' }
      let(:json) do
        {
          game:   raw_name,
          title:  title,
          tags:   []
        }.to_json
      end
    end
  end

  let(:title)    { 'Sample Game: Remastered' }
  let(:tag)      { '(Vita/PS4)' }
  let(:raw_name) { "#{title} #{tag}".strip }
end
