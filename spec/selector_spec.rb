require_relative 'spec_helper'
require 'byebug'
require_relative '../selector'

RSpec.describe Selector do
  describe '#random' do
    subject { Selector.new(:unplayed).random }

    context 'when the data is available' do
      before { stub_url }

      it 'returns the proper hash' do
        expect(subject).to have_key :name
        expect(subject).to have_key :tags
      end
    end

    context 'when the data is unavailable' do
      before { stub_url_failure }

      it { is_expected.to be_nil }
    end
  end

  describe '#all' do
    subject { Selector.new(:unplayed).all }

    context 'when the data is available' do
      before  { stub_url }

      it 'lists all unplayed games' do
        expect(subject.size).to eq 23
      end
    end

    context 'when the data is unavailable' do
      before  { stub_url_failure }

      it 'lists no games' do
        expect(subject.size).to be 0
      end
    end
  end

  describe '#error' do
    subject { Selector.new(:unplayed).error }

    context 'when the data is available' do
      before  { stub_url }

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
      before  { stub_url }

      it { is_expected.to be_falsey }
    end

    context 'when the data is unavailable' do
      before  { stub_url_failure }

      it { is_expected.to be true }
    end
  end

  let(:fixture_file) do
    File.join Dir.pwd, 'spec', 'fixtures', 'sample.html'
  end

  def stub_url
    stub_request(:get, described_class::URL).
      to_return status: 200, body: File.read(fixture_file)
  end

  def stub_url_failure
    stub_request(:get, described_class::URL).
      to_return status: 400
  end
end
