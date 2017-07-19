require_relative 'spec_helper'
require_relative '../lib/name_selector'

RSpec.describe NameSelector do
  before { allow(Site).to receive :select }

  describe '#all' do
    before  { stub_html_content }
    subject { described_class.new.all }

    context 'when the data is available' do
      it 'returns all names' do
        expect(subject.size).to eq items.size

        subject.each do |s|
          expect(s).to be_a Name
        end
      end

      let(:items) { ['a', 'b'] }
    end

    context 'when the data is unavailable' do
      it { is_expected.to eq [] }

      let(:items) { [] }
    end

    let(:html_content) { FakeHtmlContent.new items: items }
  end

  describe '#random' do
    before  { stub_html_content }
    subject { described_class.new.random }

    context 'when the data is available' do
      it 'returns a single name' do
        expect(subject).to be_a Name
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
