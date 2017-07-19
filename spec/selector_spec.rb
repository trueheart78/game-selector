require_relative 'spec_helper'
require_relative '../lib/selector'

RSpec.describe Selector do
  before { allow(Site).to receive :select }

  describe 'constants' do
    describe 'TYPES' do
      subject { described_class::TYPES }

      it { is_expected.to eq types }

      let(:types) { %w[unplayed for-fun playing] }
    end
  end

  describe '#random' do
    before  { stub_html_content }
    subject { described_class.new(:unplayed).random }

    context 'when the data is available' do
      it 'returns a single game' do
        expect(subject).to be_a Game
      end

      let(:items) { ['a', 'b'] }
    end

    context 'when the data is unavailable' do
      it { is_expected.to be_nil }

      let(:items) { [] }
    end

    let(:html_content) { FakeHtmlContent.new items: items }
  end

  def stub_html_content
    allow_any_instance_of(Html).to receive(:content).and_return html_content
  end
end
