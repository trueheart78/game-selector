require_relative 'spec_helper'
require_relative '../lib/game'

RSpec.describe Game do
  describe '#to_s' do
    subject { Game.new(name).to_s }

    it 'returns the passed name' do
      expect(subject).to eq name
    end
  end

  describe '#name' do
    subject { Game.new(name).name }

    it 'returns the base game name' do
      expect(subject).to eq base
    end
  end

  describe '#tags' do
    subject { Game.new(name).tags }

    it 'returns the related tags' do
      expect(subject).to eq %w[Vita PS4]
    end
  end

  let(:base) { 'Sample Game: Remastered' }
  let(:tag)  { '(Vita/PS4)' }
  let(:name) { "#{base} #{tag}" }
end
