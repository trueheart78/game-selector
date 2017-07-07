require_relative 'spec_helper'
require_relative '../lib/selector'

RSpec.describe Selector do
  before { allow(Site).to receive(:select).and_return url }

  describe 'constants' do
    describe 'TYPES' do
      subject { described_class::TYPES }

      it { is_expected.to eq types }

      let(:types) { %w[unplayed for-fun playing] }
    end
  end

  describe '#random' do
    subject { Selector.new(:unplayed).random }

    context 'when the data is available' do
      before { stub_url }

      it 'returns a single game' do
        expect(subject).to be_a Game
      end
    end

    context 'when the data is unavailable' do
      before { stub_url_failure }

      it { is_expected.to be_nil }
    end
  end

  describe '#all' do
    subject { Selector.new(:unplayed).all }

    context 'when parsing a page with the comment tags' do
      before { stub_url }

      it 'lists all unplayed games' do
        expect(subject.size).to eq 23
      end
    end

    context 'when parsing a page without the comment tags' do
      before { stub_url }

      it 'lists all unplayed games' do
        expect(subject.size).to eq 49
      end

      let(:fixture_file) do
        File.join Dir.pwd, 'spec', 'fixtures', 'without-comments.html'
      end
    end

    context 'when parsing a page with extra elements in the list items' do
      before { stub_url }

      it 'lists all unplayed games' do
        expect(subject.size).to eq 49
      end

      let(:fixture_file) do
        File.join Dir.pwd, 'spec', 'fixtures', 'extra-elements.html'
      end
    end

    context 'when the data is unavailable' do
      before { stub_url_failure }

      it 'lists no games' do
        expect(subject.size).to be 0
      end
    end
  end

  describe '#error' do
    subject { Selector.new(:unplayed).error }

    context 'when the data is available' do
      before { stub_url }

      it { is_expected.to be_nil }
    end

    context 'when the data is unavailable' do
      before  { stub_url_failure }

      it 'has the expected message' do
        expect(subject).to eq 'No matching data found'
      end
    end
  end

  describe '#error?' do
    subject { Selector.new(:unplayed).error? }

    context 'when the data is available' do
      before { stub_url }

      it { is_expected.to be_falsey }
    end

    context 'when the data is unavailable' do
      before { stub_url_failure }

      it { is_expected.to be true }
    end
  end

  let(:fixture_file) do
    File.join Dir.pwd, 'spec', 'fixtures', 'sample.html'
  end
  let(:url) { 'http://www.butts.com/games/' }

  def stub_url
    stub_request(:get, url)
      .to_return status: 200, body: File.read(fixture_file)
  end

  def stub_url_failure
    stub_request(:get, url)
      .to_return status: 400
  end
end
