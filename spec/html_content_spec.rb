require_relative 'spec_helper'
require_relative '../lib/html_content'

RSpec.describe HtmlContent do
  describe '#items' do
    subject { described_class.new(content).items }

    context 'when there is content' do
      it 'it is a populated array' do

      end

      let(:content) { sample_fixture_data }
    end

    context 'when there is no content' do
      it 'is an empty array' do

      end

      let(:content) { '' }
    end
  end

  describe '#valid?' do

  end

  describe '#items' do
    context ':unplayed' do
      subject { described_class.new(content, type).items }

      context 'when parsing a page with the comment tags' do
        it 'lists all unplayed games' do
          expect(subject.size).to eq 23
        end

        let(:content) { fixture_data :sample }
      end

      context 'when parsing a page without the comment tags' do
        it 'lists all unplayed games' do
          expect(subject.size).to eq 49
        end

        let(:content) { fixture_data :without_comments }
      end

      context 'when parsing a page with extra elements in the list items' do
        it 'lists all unplayed games' do
          expect(subject.size).to eq 49
        end

        let(:content) { fixture_data :extra_elements }
      end

      context 'when the data is unavailable' do
        it 'lists no games' do
          expect(subject.size).to be 0
        end

        let(:content) { '' }
      end

      let(:type) { :unplayed }
    end
  end

  describe '#error' do
    subject { described_class.new(content).error }

    context 'when there is content' do
      it 'it is nil' do
        expect(subject).to eq nil
      end

      let(:content) { sample_fixture_data }
    end

    context 'when there is no content' do
      it 'has the expected message' do
        expect(subject).to eq 'No matching data found'
      end

      let(:content) { '' }
    end
  end

  describe '#error?' do
    subject { described_class.new(content).error? }

    context 'when there is content' do
      it { is_expected.to be_falsey }

      let(:content) { sample_fixture_data }
    end

    context 'when there is no content' do
      it { is_expected.to be true }

      let(:content) { '' }
    end
  end
end
